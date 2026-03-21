import 'dart:developer' as dev;
import 'dart:io';
import 'dart:ui' as ui;
import 'package:docguard/core/errors/failures.dart';
import 'package:docguard/core/attachments/queue.dart';
import 'package:docguard/features/documents/data/models/category_model.dart';
import 'package:docguard/features/documents/data/models/document_model.dart';
import 'package:docguard/features/documents/domain/entities/category_entity.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class DocumentRepositoryImpl implements IDocumentRepository {
  final PowerSyncDatabase _db;
  final SupabaseClient _supabase;

  DocumentRepositoryImpl(this._db, this._supabase);

  @override
  Future<Either<Failure, DocumentEntity>> uploadScannedDocument({
    required String filePath,
  }) async {
    debugPrint('🚀 [REPO] uploadScannedDocument started for $filePath');
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        debugPrint('❌ [REPO] Auth error: User not authenticated');
        return const Left(AuthFailure('User not authenticated'));
      }

      final documentId = const Uuid().v4();
      final file = filePath.startsWith('file://')
          ? File.fromUri(Uri.parse(filePath))
          : File(filePath);
          
      if (!await file.exists()) {
        debugPrint('❌ [REPO] File NOT FOUND at $filePath (Resolved path: ${file.path})');
        return Left(DatabaseFailure('Scan file not found at $filePath'));
      }
      
      final fileName = file.path.split('/').last;
      debugPrint('📄 [REPO] File identified: $fileName, ID: $documentId, Size: ${await file.length()} bytes');

      // 1. Create a local record first with minimal data
      DocumentModel document = DocumentModel(
        id: documentId,
        userId: userId,
        status: 'pending',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      debugPrint('💾 [REPO] Inserting document $documentId into local DB...');
      await _db.execute(
        '''
        INSERT INTO documents (
          id, user_id, status, ai_processed, report_type, is_favorite, 
          file_extension, thumbnail_extension, file_size, created_at, updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          document.id,
          document.userId,
          document.status,
          0,
          'auto_scan', 
          0,
          'pdf', // Scanned documents are PDFs
          'png', // Thumbnails are PNGs
          await file.length(),
          document.createdAt?.toIso8601String(),
          document.updatedAt?.toIso8601String(),
        ],
      );
      debugPrint('✅ [REPO] Document record inserted.');

      // 2. Queue the file for upload via AttachmentQueue
      debugPrint('📤 [REPO] Calling saveDocumentAttachment for $documentId...');
      try {
        await saveDocumentAttachment(
          file.openRead(),
          documentId,
          fileName: fileName,
          size: await file.length(),
        );
        debugPrint('✅ [REPO] saveDocumentAttachment returned success.');
      } catch (e) {
        debugPrint('❌ [REPO] error in saveDocumentAttachment: $e');
        // We continue anyway so the record is not lost, but this is a problem
      }

      // 3. Generate Thumbnail and queue it
      try {
        debugPrint('🖼️ [REPO] Generating thumbnail...');
        // Final image bytes (already encoded as PNG/JPEG by the renderer)
        Uint8List? thumbBytes;

        try {
          final pdf = PdfImageRenderer(path: filePath);
          await pdf.open();
          await pdf.openPage(pageIndex: 0);

          final pageSize = await pdf.getPageSize(pageIndex: 0);
          const thumbWidth = 300;
          final thumbHeight =
              (thumbWidth * pageSize.height / pageSize.width).round();

          thumbBytes = await pdf.renderPage(
            pageIndex: 0,
            x: 0,
            y: 0,
            width: thumbWidth,
            height: thumbHeight,
            scale: 1,
            background: const ui.Color(0xFFFFFFFF),
          );

          await pdf.closePage(pageIndex: 0);
          pdf.close();
        } catch (e) {
          debugPrint('❌ [REPO] PdfImageRenderer error: $e');
        }

        if (thumbBytes != null && thumbBytes.isNotEmpty) {
          debugPrint('🎨 [REPO] Thumbnail rendered successfully (${thumbBytes.length} bytes)');
          
          final tempDir = await getTemporaryDirectory();
          final thumbFile = File('${tempDir.path}/${documentId}_thumb.png');
          await thumbFile.writeAsBytes(thumbBytes);
          debugPrint('💾 [REPO] Temporary thumbnail saved: ${thumbFile.lengthSync()} bytes');

          final attachment = await saveThumbnailAttachment(
            thumbFile.openRead(),
            documentId,
            fileName: '${documentId}_thumb.png',
            size: await thumbFile.length(),
            mediaType: 'image/png',
          );
            debugPrint('✅ [REPO] saveThumbnailAttachment finished. ID: ${attachment.id}');
            
            // Persist the thumbnail ID immediately so the UI and PowerSync see it
            await _db.execute(
              'UPDATE documents SET thumbnail_url = ? WHERE id = ?',
              [attachment.id, documentId],
            );
            debugPrint('💾 [REPO] DB updated with thumbnail_url: ${attachment.id}');

            // Update the local document object to include the thumbnail URL
            document = document.copyWith(thumbnailUrl: attachment.id);
          }
        } catch (e, stack) {
          debugPrint('❌ [REPO] Thumbnail generation failed: $e');
          dev.log('Thumbnail generation failed', error: e, stackTrace: stack);
        }

        debugPrint('🏁 [REPO] uploadScannedDocument COMPLETE for $documentId');
        return Right(document);
      } catch (e, stack) {
        debugPrint('💥 [REPO] FATAL ERROR in uploadScannedDocument: $e');
        dev.log('Fatal error in uploadScannedDocument',
            error: e, stackTrace: stack);
        return Left(DatabaseFailure(e.toString()));
      }
    }

    @override
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
    }) async {
      try {
        final userId = _supabase.auth.currentUser?.id;
        if (userId == null) {
          return const Left(AuthFailure('User not authenticated'));
        }

        final documentId = const Uuid().v4();
        final file = filePath.startsWith('file://')
            ? File.fromUri(Uri.parse(filePath))
            : File(filePath);
        final fileName = file.path.split('/').last;

        // 1. Create a local record first (Local-First)
        DocumentModel document = DocumentModel(
          id: documentId,
          userId: userId,
          categoryId: categoryId,
          ownerFullName: ownerFullName,
          docNumber: docNumber,
          description: description,
          city: city,
          neighborhood: neighborhood,
          countryCode: countryCode,
          reportType: reportType,
          status: 'pending',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _db.execute(
          '''
          INSERT INTO documents (
            id, user_id, category_id, owner_full_name, doc_number, 
            description, city, neighborhood, country_code, report_type, 
            file_extension, file_size, status, ai_processed, created_at, updated_at
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
          ''',
          [
            document.id,
            document.userId,
            document.categoryId,
            document.ownerFullName,
            document.docNumber,
            document.description,
            document.city,
            document.neighborhood,
            document.countryCode,
            document.reportType,
            'pdf', // Default extension for uploads
            await file.length(),
            document.status,
            0,
            document.createdAt?.toIso8601String(),
            document.updatedAt?.toIso8601String(),
          ],
        );

        // 2. Queue the file for upload via AttachmentQueue
        await saveDocumentAttachment(
          file.openRead(),
          documentId,
          fileName: fileName,
          size: await file.length(),
        );

        // 3. Generate Thumbnail and queue it (Same logic as uploadScannedDocument)
        try {
          debugPrint('🖼️ [REPO] Generating thumbnail for upload...');
          Uint8List? thumbBytes;
          try {
            final pdf = PdfImageRenderer(path: file.path);
            await pdf.open();
            await pdf.openPage(pageIndex: 0);
            final pageSize = await pdf.getPageSize(pageIndex: 0);
            const thumbWidth = 300;
            final thumbHeight =
                (thumbWidth * pageSize.height / pageSize.width).round();
            thumbBytes = await pdf.renderPage(
              pageIndex: 0,
              x: 0,
              y: 0,
              width: thumbWidth,
              height: thumbHeight,
              scale: 1,
              background: const ui.Color(0xFFFFFFFF),
            );
            await pdf.closePage(pageIndex: 0);
            pdf.close();
          } catch (e) {
            debugPrint('❌ [REPO] PdfImageRenderer error during upload: $e');
          }

          if (thumbBytes != null && thumbBytes.isNotEmpty) {
            final tempDir = await getTemporaryDirectory();
            final thumbFile = File('${tempDir.path}/${documentId}_thumb.png');
            await thumbFile.writeAsBytes(thumbBytes);

            final attachment = await saveThumbnailAttachment(
              thumbFile.openRead(),
              documentId,
              fileName: '${documentId}_thumb.png',
              size: await thumbFile.length(),
              mediaType: 'image/png',
            );

            await _db.execute(
              'UPDATE documents SET thumbnail_url = ?, thumbnail_extension = ? WHERE id = ?',
              [attachment.id, 'png', documentId],
            );
            document = document.copyWith(
              thumbnailUrl: attachment.id,
              thumbnailExtension: 'png',
            );
          }
        } catch (e) {
          debugPrint('❌ [REPO] Thumbnail generation failed during upload: $e');
        }

        return Right(document);
      } catch (e) {
        return Left(DatabaseFailure(e.toString()));
      }
    }

  @override
  Stream<List<DocumentEntity>> watchUserDocuments() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return Stream.value([]);

    return _db
        .watch(
          'SELECT * FROM documents WHERE user_id = ? ORDER BY created_at DESC',
          parameters: [userId],
        )
        .map((results) {
          return results
              .map((row) => DocumentModel.fromRow(row).toEntity())
              .toList();
        });
  }

  @override
  Stream<List<DocumentEntity>> watchFavoriteDocuments() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return Stream.value([]);

    return _db
        .watch(
          'SELECT * FROM documents WHERE user_id = ? AND is_favorite = 1 ORDER BY created_at DESC',
          parameters: [userId],
        )
        .map((results) {
          return results
              .map((row) => DocumentModel.fromRow(row).toEntity())
              .toList();
        });
  }

  @override
  Stream<DocumentEntity?> watchDocumentStatus(String documentId) {
    return _db.watch(
      'SELECT * FROM documents WHERE id = ?',
      parameters: [documentId],
    ).map((results) {
      if (results.isEmpty) return null;
      return DocumentModel.fromRow(results.first).toEntity();
    });
  }

  @override
  Future<Either<Failure, DocumentEntity>> toggleFavorite({
    required String documentId,
    required bool isFavorite,
  }) async {
    try {
      await _db.execute(
        'UPDATE documents SET is_favorite = ? WHERE id = ?',
        [isFavorite ? 1 : 0, documentId],
      );

      final results = await _db.getOptional(
        'SELECT * FROM documents WHERE id = ?',
        [documentId],
      );

      if (results != null) {
        final doc = DocumentModel.fromRow(results).toEntity();
        return Right(doc);
      }
      return const Left(DatabaseFailure('Document not found after update'));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final results = await _db.getAll(
        'SELECT * FROM categories ORDER BY name ASC',
      );
      final categories = results
          .map((row) => CategoryModel.fromRow(row).toEntity())
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    return _db.watch('SELECT * FROM categories ORDER BY name ASC').map((results) {
      return results
          .map((row) => CategoryModel.fromRow(row).toEntity())
          .toList();
    });
  }
}
