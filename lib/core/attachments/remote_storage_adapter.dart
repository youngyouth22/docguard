import 'dart:typed_data';
import 'package:docguard/core/constants/app_constants.dart';
import 'package:docguard/di/injection.dart';
import 'package:powersync_core/attachments/attachments.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logging/logging.dart';

class SupabaseStorageAdapter implements RemoteStorage {
  static final _log = Logger('SupabaseStorageAdapter');

  static void setLogLevel(Level level) {
    _log.level = level;
  }

  @override
  Future<void> uploadFile(
    Stream<List<int>> fileData,
    Attachment attachment,
  ) async {
    _checkSupabaseBucketIsConfigured();

    _log.info('--- Starting uploadFile for ${attachment.filename} ---');

    try {
      // Collect the stream into bytes
      final bytes = await fileData.fold<List<int>>(
        [],
        (previous, element) => previous..addAll(element),
      );
      final buffer = Uint8List.fromList(bytes);

      _log.info('Collected ${buffer.length} bytes for ${attachment.filename}');

      // Get current user ID for secure file path
      final userId = getIt<SupabaseClient>().auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User must be authenticated to upload files');
      }

      // Normalize filename by stripping 'p:' and 'processed/' prefix
      final filename = (attachment.id.startsWith('p:')
              ? attachment.id.replaceFirst('p:', '')
              : attachment.filename)
          .replaceFirst('processed/', '');

      final String path;
      if (attachment.id.startsWith('p:')) {
        path = '$userId/processed/$filename';
      } else {
        path = '$userId/$filename';
      }
      _log.info(
        'Uploading to: $path in bucket: ${AppConstants.supabaseStorageBucket}',
      );

      // Upload directly the buffer
      final response = await getIt<SupabaseClient>().storage
          .from(AppConstants.supabaseStorageBucket)
          .uploadBinary(
            path,
            buffer,
            fileOptions: FileOptions(
              contentType: attachment.mediaType ?? 'application/octet-stream',
              upsert: true,
            ),
          );

      _log.info('✅ Successfully uploaded $path. Response: $response');
    } catch (error, stackTrace) {
      _log.severe(
        '❌ Error uploading ${attachment.filename}',
        error,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<Stream<List<int>>> downloadFile(Attachment attachment) async {
    _checkSupabaseBucketIsConfigured();

    try {
      _log.info('Downloading: ${attachment.filename}');

      final userId = getIt<SupabaseClient>().auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User must be authenticated to download files');
      }

      // Normalize filename by stripping 'p:' and 'processed/'
      final filename = (attachment.id.startsWith('p:')
              ? attachment.id.replaceFirst('p:', '')
              : attachment.filename)
          .replaceFirst('processed/', '');

      final String path;
      if (attachment.id.startsWith('p:')) {
        path = '$userId/processed/$filename';
      } else {
        path = '$userId/$filename';
      }

      final fileBlob = await getIt<SupabaseClient>().storage
          .from(AppConstants.supabaseStorageBucket)
          .download(path);

      _log.info('✅ Downloaded $path (${fileBlob.length} bytes)');

      return Stream.value(fileBlob);
    } catch (error, stackTrace) {
      _log.severe(
        '❌ Error downloading ${attachment.filename}',
        error,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> deleteFile(Attachment attachment) async {
    _checkSupabaseBucketIsConfigured();

    try {
      final userId = getIt<SupabaseClient>().auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User must be authenticated to delete files');
      }

      // Normalize filename by stripping 'p:' and 'processed/'
      final filename = (attachment.id.startsWith('p:')
              ? attachment.id.replaceFirst('p:', '')
              : attachment.filename)
          .replaceFirst('processed/', '');

      final String path;
      if (attachment.id.startsWith('p:')) {
        path = '$userId/processed/$filename';
      } else {
        path = '$userId/$filename';
      }

      await getIt<SupabaseClient>().storage
          .from(AppConstants.supabaseStorageBucket)
          .remove([path]);

      _log.info('✅ Successfully deleted $path');
    } catch (error, stackTrace) {
      _log.severe('❌ Error deleting ${attachment.filename}', error, stackTrace);
      rethrow;
    }
  }

  void _checkSupabaseBucketIsConfigured() {
    if (AppConstants.supabaseStorageBucket.isEmpty) {
      throw Exception(
        'Supabase storage bucket is not configured in AppConstants',
      );
    }
  }
}
