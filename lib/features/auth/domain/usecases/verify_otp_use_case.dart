import 'package:dartz/dartz.dart';
import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/core/usecases/usecase.dart';
import 'package:docguard/features/auth/domain/entities/user_entity.dart';
import 'package:docguard/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

/// Use case for verifying an OTP for a user.
class VerifyOtpUseCase implements UseCase<UserEntity, VerifyOtpParams> {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(VerifyOtpParams params) async {
    return await _repository.verifyOtp(
      email: params.email,
      token: params.token,
    );
  }
}

class VerifyOtpParams extends Equatable {
  final String email;
  final String token;

  const VerifyOtpParams({required this.email, required this.token});

  @override
  List<Object?> get props => [email, token];
}
