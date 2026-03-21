part of 'verify_otp_bloc.dart';

@freezed
abstract class VerifyOtpEvent with _$VerifyOtpEvent {
  const factory VerifyOtpEvent.submitOtp({
    required String email,
    required String token,
  }) = _SubmitOtp;

  const factory VerifyOtpEvent.resendOtp({required String email}) = _ResendOtp;
}
