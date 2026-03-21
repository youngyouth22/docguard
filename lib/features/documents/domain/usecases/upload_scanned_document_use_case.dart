import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';
import 'package:dartz/dartz.dart';

class UploadScannedDocumentUseCase {
  final IDocumentRepository _repository;

  UploadScannedDocumentUseCase(this._repository);

  Future<Either<Failure, DocumentEntity>> call({required String filePath}) {
    return _repository.uploadScannedDocument(filePath: filePath);
  }
}
