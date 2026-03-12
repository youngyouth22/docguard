import 'package:docguard/features/auth/domain/usecases/auth_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SignUpUseCase _signUpUseCase;

  RegisterBloc(this._signUpUseCase) : super(RegisterState.initial()) {
    on<_RegisterSubmitted>(_onRegisterSubmitted);
    on<_PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<_ConfirmPasswordVisibilityToggled>(_onConfirmPasswordVisibilityToggled);
  }

  Future<void> _onRegisterSubmitted(
    _RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (event.password != event.confirmPassword) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: "Passwords do not match",
        ),
      );
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));
    final result = await _signUpUseCase(
      SignUpParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (user) => emit(state.copyWith(status: RegisterStatus.success)),
    );
  }

  void _onPasswordVisibilityToggled(
    _PasswordVisibilityToggled event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordVisibilityToggled(
    _ConfirmPasswordVisibilityToggled event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }
}
