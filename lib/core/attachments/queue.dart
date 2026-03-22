import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:powersync/powersync.dart';
import 'package:powersync_core/attachments/attachments.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'local_storage_unsupported.dart'
    if (dart.library.io) 'local_storage_native.dart';
import 'remote_storage_adapter.dart';

late AttachmentQueue attachmentQueue;
final remoteStorage = SupabaseStorageAdapter();
late Logger logger;

Future<void> initializeAttachmentQueue(PowerSyncDatabase db) async {
  hierarchicalLoggingEnabled = true;

  logger = Logger('AttachmentQueue')..level = Level.ALL;
  SupabaseStorageAdapter.setLogLevel(Level.ALL);

  // Listen to logs and print them to console
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}',
    );
    if (record.error != null) {
      debugPrint('Error: ${record.error}');
    }
  });

  attachmentQueue = AttachmentQueue(
    db: db,
    remoteStorage: remoteStorage,
    logger: logger,
    localStorage: await localAttachmentStorage(),
    attachmentsQueueTableName: 'attachments',
    syncInterval: const Duration(seconds: 5),
    errorHandler: AttachmentErrorHandler(
      onDeleteError: (attachment, exception, stackTrace) {
        logger.severe(
          'Error deleting ${attachment.filename}',
          exception,
          stackTrace,
        );
        return Future.value(true);
      },
      onDownloadError: (attachment, exception, stackTrace) {
        logger.severe(
          'Error downloading ${attachment.filename}',
          exception,
          stackTrace,
        );
        if (exception.toString().contains('Object not found')) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      onUploadError: (attachment, exception, stackTrace) {
        logger.severe(
          'Error uploading ${attachment.filename}',
          exception,
          stackTrace,
        );
        if (exception.toString().contains('Object not found')) {
          return Future.value(false);
        }
        return Future.value(true);
      },
    ),
    watchAttachments: () => db
        .watch('''
      SELECT file_url as id, file_extension as file_extension FROM documents WHERE file_url IS NOT NULL
      UNION ALL
      SELECT 'p:' || file_url_word || '.docx' as id, 'docx' as file_extension FROM documents WHERE file_url_word IS NOT NULL
      UNION ALL
      SELECT 'p:' || file_url_pdf_pro || '.pdf' as id, 'pdf' as file_extension FROM documents WHERE file_url_pdf_pro IS NOT NULL
      UNION ALL
      SELECT 'p:' || file_url_markdown || '.md' as id, 'md' as file_extension FROM documents WHERE file_url_markdown IS NOT NULL
      UNION ALL
      SELECT thumbnail_url as id, thumbnail_extension as file_extension FROM documents WHERE thumbnail_url IS NOT NULL
    ''')
        .map(
          (results) => [
            for (final row in results)
              WatchedAttachmentItem(
                id: row['id'] as String,
                fileExtension: row['file_extension'] as String,
              ),
          ],
        ),
  );
  await attachmentQueue.startSync();
}

Future<Attachment> saveDocumentAttachment(
  Stream<List<int>> fileData,
  String documentId, {
  required String fileName,
  required int size,
  String mediaType = 'application/octet-stream',
}) async {
  debugPrint('📤 [QUEUE] saveDocumentAttachment for $documentId');
  try {
    final extension = fileName.split('.').last;
    // Save the file using the AttachmentQueue API
    final attachment = await attachmentQueue.saveFile(
      data: fileData,
      mediaType: mediaType,
      fileExtension: extension,
      metaData: 'Attachment for document: $documentId',
      updateHook: (context, attachment) async {
        debugPrint(
          '🔗 [QUEUE] updateHook binding $documentId to ${attachment.id}',
        );
        // Update the document item to reference this attachment
        await context.execute(
          'UPDATE documents SET file_url = ? WHERE id = ?',
          [attachment.id, documentId],
        );
        debugPrint('✅ [QUEUE] updateHook finished for $documentId');
      },
    );
    debugPrint('🎉 [QUEUE] saveFile returned successfully for $documentId');
    return attachment;
  } catch (e) {
    debugPrint('❌ [QUEUE] saveFile ERROR: $e');
    rethrow;
  }
}

Future<Attachment> saveThumbnailAttachment(
  Stream<List<int>> fileData,
  String documentId, {
  required String fileName,
  required int size,
  String mediaType = 'image/jpeg',
}) async {
  debugPrint('📤 [QUEUE] saveThumbnailAttachment for $documentId');
  try {
    final extension = fileName.split('.').last;
    // Save the file using the AttachmentQueue API
    final attachment = await attachmentQueue.saveFile(
      data: fileData,
      mediaType: mediaType,
      fileExtension: extension,
      metaData: 'Thumbnail for document: $documentId',
      updateHook: (context, attachment) async {
        debugPrint(
          '🔗 [QUEUE] thumbnail updateHook binding $documentId to ${attachment.id}',
        );
        // Update BOTH thumbnail_url AND thumbnail_extension
        await context.execute(
          'UPDATE documents SET thumbnail_url = ?, thumbnail_extension = ? WHERE id = ?',
          [attachment.id, extension, documentId],
        );
        debugPrint('✅ [QUEUE] thumbnail updateHook finished for $documentId');
      },
    );
    debugPrint('🎉 [QUEUE] saveThumbnail return success for $documentId');
    return attachment;
  } catch (e) {
    debugPrint('❌ [QUEUE] saveThumbnail ERROR: $e');
    rethrow;
  }
}

Future<Attachment> deleteDocumentAttachment(String fileId) async {
  return await attachmentQueue.deleteFile(
    attachmentId: fileId,
    updateHook: (context, attachment) async {
      await context.execute(
        'UPDATE documents SET file_url = NULL WHERE file_url = ?',
        [fileId],
      );
    },
  );
}

Future<String?> getLocalDocumentPath(
  String fileId,
  PowerSyncDatabase db,
) async {
  try {
    // Récupérer l'attachment avec son état
    final results = await db.getOptional(
      'SELECT id, local_uri, state, filename FROM attachments WHERE id = ?',
      [fileId],
    );

    if (results == null) {
      debugPrint('⚠️ Attachment $fileId not found in attachments table');
      return null;
    }

    final localUri = results['local_uri'] as String?;

    // Vérifier que le local_uri est présent
    if (localUri == null || localUri.isEmpty) {
      debugPrint('⚠️ Attachment $fileId has no local_uri');
      return null;
    }

    // Resolve path if it's relative
    String absolutePath = localUri;
    if (!p.isAbsolute(localUri)) {
      final appDocDir = await getApplicationDocumentsDirectory();
      absolutePath = p.join(appDocDir.path, localUri);
    }

    final file = File(absolutePath);
    if (await file.exists()) {
      return absolutePath;
    } else {
      debugPrint('❌ File does not exist at path: $absolutePath');
      return null;
    }
  } catch (e) {
    debugPrint('❌ Error getting local path for $fileId: $e');
    return null;
  }
}

/// Helper to resolve local path with optional prefixing for processed documents.
Future<String?> getLocalDocumentPathWithPrefix(
  String? fileId,
  PowerSyncDatabase db, {
  bool isProcessed = false,
}) async {
  if (fileId == null || fileId.isEmpty) return null;
  final finalId = isProcessed ? 'p:$fileId' : fileId;
  return getLocalDocumentPath(finalId, db);
}

/// Watches the local path of an attachment.
Stream<String?> watchLocalDocumentPath(
  String fileId,
  PowerSyncDatabase db,
) {
  return db.watch(
    'SELECT local_uri, state FROM attachments WHERE id = ?',
    parameters: [fileId],
  ).asyncMap((results) async {
    if (results.isEmpty) {
      debugPrint('🔍 [Queue] No results found for ID: $fileId');
      return null;
    }

    final row = results.first;
    final state = row['state'] as int?;
    final localUri = row['local_uri'] as String?;

    debugPrint('🔍 [Queue] ID: $fileId, State: $state, localUri: $localUri');

    if (localUri == null || localUri.isEmpty) {
      return null;
    }

    // Resolve path if it's relative
    String absolutePath = localUri;
    if (!p.isAbsolute(localUri)) {
      final appDocDir = await getApplicationDocumentsDirectory();
      absolutePath = p.join(appDocDir.path, localUri);
    }

    if (await File(absolutePath).exists()) {
      return absolutePath;
    }
    return null;
  });
}

/// Helper to watch local path with optional prefixing.
Stream<String?> watchLocalDocumentPathWithPrefix(
  String? fileId,
  PowerSyncDatabase db, {
  bool isProcessed = false,
  String? extension,
}) {
  if (fileId == null || fileId.isEmpty) return Stream.value(null);
  String finalId = isProcessed ? 'p:$fileId' : fileId;
  if (isProcessed && extension != null) {
    if (!finalId.endsWith('.$extension')) {
      finalId = '$finalId.$extension';
    }
  }
  return watchLocalDocumentPath(finalId, db);
}

/// Helper to get local path for a document ID as a Future.
Future<String?> getLocalPath(String fileId, PowerSyncDatabase db) async {
  final results = await db.getOptional(
    'SELECT local_uri, state FROM attachments WHERE id = ?',
    [fileId],
  );

  if (results == null) return null;

  final localUri = results['local_uri'] as String?;

  if (localUri == null || localUri.isEmpty) {
    return null;
  }

  // Resolve path if it's relative
  String absolutePath = localUri;
  if (!p.isAbsolute(localUri)) {
    final appDocDir = await getApplicationDocumentsDirectory();
    absolutePath = p.join(appDocDir.path, localUri);
  }

  if (await File(absolutePath).exists()) {
    return absolutePath;
  }
  return null;
}
