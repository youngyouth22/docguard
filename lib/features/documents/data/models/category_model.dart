import 'package:docguard/features/documents/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.isOfficial,
    super.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isOfficial: (json['is_official'] as int?) == 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  factory CategoryModel.fromRow(Map<String, dynamic> row) {
    return CategoryModel(
      id: row['id'] as String,
      name: row['name'] as String,
      isOfficial: (row['is_official'] as int?) == 1,
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_official': isOfficial ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      isOfficial: isOfficial,
      createdAt: createdAt,
    );
  }
}
