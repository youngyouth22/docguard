import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:docguard/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:docguard/features/auth/domain/usecases/resend_otp_use_case.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';
part 'verify_otp_bloc.freezed.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  VerifyOtpBloc({
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  }) : _verifyOtpUseCase = verifyOtpUseCase,
       _resendOtpUseCase = resendOtpUseCase,
       super(const VerifyOtpState.initial()) {
    on<_SubmitOtp>(_onSubmitOtp);
    on<_ResendOtp>(_onResendOtp);
  }

  Future<void> _onSubmitOtp(
    _SubmitOtp event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(const VerifyOtpState.loading());
    final result = await _verifyOtpUseCase(
      VerifyOtpParams(email: event.email, token: event.token),
    );

    result.fold(
      (failure) => emit(VerifyOtpState.failure(failure.message)),
      (_) => emit(const VerifyOtpState.success()),
    );
  }

  Future<void> _onResendOtp(
    _ResendOtp event,
    Emitter<VerifyOtpState> emit,
  ) async {
    final result = await _resendOtpUseCase(ResendOtpParams(email: event.email));

    result.fold(
      (failure) => emit(VerifyOtpState.failure(failure.message)),
      (_) => null, // Maybe show a success message in UI via listener
    );
  }
}
