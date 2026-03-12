import 'package:docguard/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel extends UserEntity with _$UserModel {
  const UserModel._() : super();

  const factory UserModel({
    required String id,
    required String email,
    String? name,
    @Default(false) bool isEmailVerified,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSupabaseUser(supabase.User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['full_name'] as String?,
      isEmailVerified: user.emailConfirmedAt != null,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      isEmailVerified: entity.isEmailVerified,
    );
  }
}
