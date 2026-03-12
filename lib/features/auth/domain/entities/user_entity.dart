import 'package:equatable/equatable.dart';

/// Represents a user in the DocGuard application.
abstract class UserEntity extends Equatable {
  const UserEntity();

  String get id;
  String get email;
  String? get name;
  bool get isEmailVerified;

  @override
  List<Object?> get props => [id, email, name, isEmailVerified];
}
