import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';

class WatchUserDocumentsUseCase {
  final IDocumentRepository repository;

  WatchUserDocumentsUseCase(this.repository);

  Stream<List<DocumentEntity>> call() {
    return repository.watchUserDocuments();
  }
}
