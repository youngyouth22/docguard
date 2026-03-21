import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';

class WatchFavoriteDocumentsUseCase {
  final IDocumentRepository _repository;

  WatchFavoriteDocumentsUseCase(this._repository);

  Stream<List<DocumentEntity>> call() {
    return _repository.watchFavoriteDocuments();
  }
}
