import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';
import 'package:dartz/dartz.dart';

class UploadAndSyncDocumentParams {
  final String filePath;
  final String categoryId;
  final String ownerFullName;
  final String docNumber;
  final String? description;
  final String? city;
  final String? neighborhood;
  final String? countryCode;
  final String? reportType;

  UploadAndSyncDocumentParams({
    required this.filePath,
    required this.categoryId,
    required this.ownerFullName,
    required this.docNumber,
    this.description,
    this.city,
    this.neighborhood,
    this.countryCode,
    this.reportType,
  });
}

class UploadAndSyncDocumentUseCase {
  final IDocumentRepository repository;

  UploadAndSyncDocumentUseCase(this.repository);

  Future<Either<Failure, DocumentEntity>> call(
    UploadAndSyncDocumentParams params,
  ) {
    return repository.uploadAndSyncDocument(
      filePath: params.filePath,
      categoryId: params.categoryId,
      ownerFullName: params.ownerFullName,
      docNumber: params.docNumber,
      description: params.description,
      city: params.city,
      neighborhood: params.neighborhood,
      countryCode: params.countryCode,
      reportType: params.reportType,
    );
  }
}
