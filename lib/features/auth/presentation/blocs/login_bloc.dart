import 'package:docguard/features/auth/domain/usecases/auth_usecases.dart';
import 'package:docguard/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUseCase _signInUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  LoginBloc(this._signInUseCase, this._resendOtpUseCase)
    : super(LoginState.initial()) {
    on<_LoginSubmitted>(_onLoginSubmitted);
    on<_PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
  }

  Future<void> _onLoginSubmitted(
    _LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading, email: event.email));
    final result = await _signInUseCase(
      SignInParams(email: event.email, password: event.password),
    );

    await result.fold((failure) async {
      if (failure.message.contains('Email not confirmed')) {
        // Resend OTP automatically as requested
        await _resendOtpUseCase(ResendOtpParams(email: event.email));
        emit(state.copyWith(status: LoginStatus.needsVerification));
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: failure.message,
          ),
        );
      }
    }, (user) async => emit(state.copyWith(status: LoginStatus.success)));
  }

  void _onPasswordVisibilityToggled(
    _PasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
}
