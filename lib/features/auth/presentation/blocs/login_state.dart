part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure, needsVerification }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    @Default(true) bool obscurePassword,
    String? errorMessage,
    String? email,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState();
}
