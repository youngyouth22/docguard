import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';

class WatchDocumentStatusUseCase {
  final IDocumentRepository repository;

  WatchDocumentStatusUseCase(this.repository);

  Stream<DocumentEntity?> call(String documentId) {
    return repository.watchDocumentStatus(documentId);
  }
}
