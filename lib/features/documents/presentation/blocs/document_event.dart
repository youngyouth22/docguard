import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/entities/category_entity.dart';

part 'document_event.freezed.dart';

@freezed
class DocumentEvent with _$DocumentEvent {
  const factory DocumentEvent.started() = Started;
  const factory DocumentEvent.uploadRequested({
    required String filePath,
    required String categoryId,
    required String ownerFullName,
    required String docNumber,
    String? description,
    String? city,
    String? neighborhood,
    String? countryCode,
    String? reportType,
  }) = UploadRequested;
  const factory DocumentEvent.documentsUpdated(List<DocumentEntity> documents) =
      DocumentsUpdated;
  const factory DocumentEvent.favoriteDocumentsUpdated(
          List<DocumentEntity> favoriteDocuments) =
      FavoriteDocumentsUpdated;
  const factory DocumentEvent.categoriesUpdated(
          List<CategoryEntity> categories) =
      CategoriesUpdated;
  const factory DocumentEvent.scannedDocumentUploadRequested(String filePath) =
      ScannedDocumentUploadRequested;
  const factory DocumentEvent.favoriteToggled(
      String documentId, bool isFavorite) = FavoriteToggled;
}
