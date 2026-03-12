part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = _AppStarted;
  const factory AuthEvent.userChanged(UserEntity? user) = _UserChanged;
  const factory AuthEvent.logoutRequested() = _LogoutRequested;
}
