part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

@freezed
abstract class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(RegisterStatus.initial) RegisterStatus status,
    @Default(true) bool obscurePassword,
    @Default(true) bool obscureConfirmPassword,
    String? errorMessage,
  }) = _RegisterState;

  factory RegisterState.initial() => const RegisterState();
}
