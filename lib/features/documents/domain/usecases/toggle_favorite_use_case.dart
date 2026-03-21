import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';
import 'package:dartz/dartz.dart';

class ToggleFavoriteUseCase {
  final IDocumentRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<Either<Failure, DocumentEntity>> call({
    required String documentId,
    required bool isFavorite,
  }) {
    return _repository.toggleFavorite(
      documentId: documentId,
      isFavorite: isFavorite,
    );
  }
}
