import 'package:dartz/dartz.dart';
import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/core/usecases/usecase.dart';
import 'package:docguard/features/auth/domain/entities/user_entity.dart';
import 'package:docguard/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

/// Use case for user sign in.
class SignInUseCase implements UseCase<UserEntity, SignInParams> {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return _repository.signIn(email: params.email, password: params.password);
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Use case for user sign up.
class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return _repository.signUp(email: params.email, password: params.password);
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;

  const SignUpParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Use case for resetting password.
class ResetPasswordUseCase implements UseCase<Unit, String> {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(String email) {
    return _repository.resetPassword(email);
  }
}

/// Use case for signing out.
class SignOutUseCase implements UseCase<Unit, NoParams> {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return _repository.signOut();
  }
}

/// Use case for getting the current session user.
class GetSessionUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository _repository;

  GetSessionUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return _repository.getSession();
  }
}
