import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/entities/category_entity.dart';

part 'document_state.freezed.dart';

enum DocumentSyncStatus { initial, inProgress, success, failure }

@freezed
abstract class DocumentState with _$DocumentState {
  const factory DocumentState({
    @Default(DocumentSyncStatus.initial) DocumentSyncStatus status,
    @Default([]) List<DocumentEntity> documents,
    @Default([]) List<DocumentEntity> favoriteDocuments,
    @Default([]) List<CategoryEntity> categories,
    @Default({})
    Map<String, bool> aiProcessingStates, // documentId -> isProcessing
    String? errorMessage,
  }) = DocumentStateImpl;
}
