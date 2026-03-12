import 'package:dartz/dartz.dart';
import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/features/auth/domain/entities/user_entity.dart';

/// Interface for authentication-related operations.
abstract class AuthRepository {
  /// Signs in a user with email and password.
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  /// Registers a new user with email and password.
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
  });

  /// Signs out the current user.
  Future<Either<Failure, Unit>> signOut();

  /// Gets the currently authenticated user session.
  Future<Either<Failure, UserEntity?>> getSession();

  /// Sends a password reset email.
  Future<Either<Failure, Unit>> resetPassword(String email);

  /// Updates the password for the current session.
  Future<Either<Failure, Unit>> updatePassword(String newPassword);

  /// Verifies email (if applicable for the provider).
  Future<Either<Failure, Unit>> verifyEmail();
}
