part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.registerSubmitted({
    required String email,
    required String password,
    required String confirmPassword,
  }) = _RegisterSubmitted;
  const factory RegisterEvent.passwordVisibilityToggled() =
      _PasswordVisibilityToggled;
  const factory RegisterEvent.confirmPasswordVisibilityToggled() =
      _ConfirmPasswordVisibilityToggled;
}
