import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure occurring during authentication processes.
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Failure occurring during database operations.
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Failure occurring when a feature is not implemented yet.
class UnimplementedFailure extends Failure {
  const UnimplementedFailure() : super('Feature not implemented yet');
}

/// Failure occurring due to network issues.
class NetworkFailure extends Failure {
  const NetworkFailure() : super('Network connection error');
}
