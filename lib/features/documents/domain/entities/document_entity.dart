import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  final String id;
  final String userId;
  final String? categoryId;
  final String? ownerFullName;
  final String? docNumber;
  final String? description;
  final String? city;
  final String? neighborhood;
  final String? countryCode;
  final String? fileUrl;
  final String? fileExtension;
  final String? fileUrlWord;
  final String? fileUrlPdfPro;
  final String? fileUrlMarkdown;
  final String? extractedContent;
  final String? reportType;
  final String? status;
  final bool aiProcessed;
  final bool isFavorite;
  final String? thumbnailUrl;
  final String? thumbnailExtension;
  final int? fileSize;
  final Map<String, dynamic>? aiMetadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DocumentEntity({
    required this.id,
    required this.userId,
    this.categoryId,
    this.ownerFullName,
    this.docNumber,
    this.description,
    this.city,
    this.neighborhood,
    this.countryCode,
    this.fileUrl,
    this.fileExtension,
    this.fileUrlWord,
    this.fileUrlPdfPro,
    this.fileUrlMarkdown,
    this.extractedContent,
    this.reportType,
    this.status,
    this.aiProcessed = false,
    this.isFavorite = false,
    this.thumbnailUrl,
    this.thumbnailExtension,
    this.fileSize,
    this.aiMetadata,
    this.createdAt,
    this.updatedAt,
  });

  DocumentEntity copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? ownerFullName,
    String? docNumber,
    String? description,
    String? city,
    String? neighborhood,
    String? countryCode,
    String? fileUrl,
    String? fileExtension,
    String? fileUrlWord,
    String? fileUrlPdfPro,
    String? fileUrlMarkdown,
    String? extractedContent,
    String? reportType,
    String? status,
    bool? aiProcessed,
    bool? isFavorite,
    String? thumbnailUrl,
    String? thumbnailExtension,
    int? fileSize,
    Map<String, dynamic>? aiMetadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DocumentEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      ownerFullName: ownerFullName ?? this.ownerFullName,
      docNumber: docNumber ?? this.docNumber,
      description: description ?? this.description,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      countryCode: countryCode ?? this.countryCode,
      fileUrl: fileUrl ?? this.fileUrl,
      fileExtension: fileExtension ?? this.fileExtension,
      fileUrlWord: fileUrlWord ?? this.fileUrlWord,
      fileUrlPdfPro: fileUrlPdfPro ?? this.fileUrlPdfPro,
      fileUrlMarkdown: fileUrlMarkdown ?? this.fileUrlMarkdown,
      extractedContent: extractedContent ?? this.extractedContent,
      reportType: reportType ?? this.reportType,
      status: status ?? this.status,
      aiProcessed: aiProcessed ?? this.aiProcessed,
      isFavorite: isFavorite ?? this.isFavorite,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      thumbnailExtension: thumbnailExtension ?? this.thumbnailExtension,
      fileSize: fileSize ?? this.fileSize,
      aiMetadata: aiMetadata ?? this.aiMetadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        categoryId,
        ownerFullName,
        docNumber,
        description,
        city,
        neighborhood,
        countryCode,
        fileUrl,
        fileExtension,
        fileUrlWord,
        fileUrlPdfPro,
        fileUrlMarkdown,
        extractedContent,
        reportType,
        status,
        aiProcessed,
        isFavorite,
        thumbnailUrl,
        thumbnailExtension,
        fileSize,
        aiMetadata,
        createdAt,
        updatedAt,
      ];
}
