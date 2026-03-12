import 'package:dartz/dartz.dart';
import 'package:docguard/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

/// Interface for all use cases in the application.
/// [T] is the success return type, [Params] is the input parameter type.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Class used when a UseCase doesn't require any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
