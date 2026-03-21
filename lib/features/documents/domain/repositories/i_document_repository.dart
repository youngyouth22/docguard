import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/features/documents/domain/entities/category_entity.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IDocumentRepository {
  /// Uploads a scanned document with minimal metadata for AI processing.
  Future<Either<Failure, DocumentEntity>> uploadScannedDocument({
    required String filePath,
  });

  /// Uploads a file to Supabase and creates a document record in PowerSync.
  Future<Either<Failure, DocumentEntity>> uploadAndSyncDocument({
    required String filePath,
    required String categoryId,
    required String ownerFullName,
    required String docNumber,
    String? description,
    String? city,
    String? neighborhood,
    String? countryCode,
    String? reportType,
  });

  /// Watches all documents for the current user.
  Stream<List<DocumentEntity>> watchUserDocuments();

  /// Watches favorite documents for the current user.
  Stream<List<DocumentEntity>> watchFavoriteDocuments();

  /// Watches a specific document's status.
  Stream<DocumentEntity?> watchDocumentStatus(String documentId);

  /// Toggles the favorite status of a document.
  Future<Either<Failure, DocumentEntity>> toggleFavorite({
    required String documentId,
    required bool isFavorite,
  });

  /// Gets all available categories.
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  /// Watches all available categories.
  Stream<List<CategoryEntity>> watchCategories();
}
