import 'package:dartz/dartz.dart';
import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/core/usecases/usecase.dart';
import 'package:docguard/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

/// Use case for resending an OTP to a user.
class ResendOtpUseCase implements UseCase<Unit, ResendOtpParams> {
  final AuthRepository _repository;

  ResendOtpUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(ResendOtpParams params) async {
    return await _repository.resendOtp(email: params.email);
  }
}

class ResendOtpParams extends Equatable {
  final String email;

  const ResendOtpParams({required this.email});

  @override
  List<Object?> get props => [email];
}
