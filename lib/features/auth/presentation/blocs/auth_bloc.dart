import 'package:docguard/core/usecases/usecase.dart';
import 'package:docguard/features/auth/domain/entities/user_entity.dart';
import 'package:docguard/features/auth/domain/usecases/auth_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetSessionUseCase _getSessionUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthBloc({
    required GetSessionUseCase getSessionUseCase,
    required SignOutUseCase signOutUseCase,
  }) : _getSessionUseCase = getSessionUseCase,
       _signOutUseCase = signOutUseCase,
       super(const AuthState.initial()) {
    on<_AppStarted>(_onAppStarted);
    on<_UserChanged>(_onUserChanged);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(_AppStarted event, Emitter<AuthState> emit) async {
    // Add a small delay to allow the splash screen animation to play
    await Future.delayed(const Duration(seconds: 2));

    final result = await _getSessionUseCase(NoParams());
    result.fold((failure) => emit(const AuthState.unauthenticated()), (user) {
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  void _onUserChanged(_UserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthState.authenticated(event.user!));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _signOutUseCase(NoParams());
    emit(const AuthState.unauthenticated());
  }
}
