import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart';
import 'package:powersync_core/sqlite3_common.dart';
import 'package:docguard/common/image_resources.dart';
import 'package:docguard/di/injection.dart';

class DocumentThumbnail extends StatelessWidget {
  final String? thumbnailUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  const DocumentThumbnail({
    super.key,
    required this.thumbnailUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (thumbnailUrl == null) {
      return Image.asset(
        ImageResources.emptyPdf,
        fit: fit,
        height: height,
        width: width,
      );
    }

    return StreamBuilder<ResultSet>(
      stream: getIt<PowerSyncDatabase>().watch(
        'SELECT id, local_uri, state, filename FROM attachments WHERE id = ?',
        parameters: [thumbnailUrl],
      ),
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Image.asset(
            ImageResources.emptyPdf,
            fit: fit,
            height: height,
            width: width,
          );
        }

        final row = snapshot.data!.first;
        final localUri = row['local_uri'] as String?;
        final state = row['state'] as int?;

        if (localUri != null && localUri.isNotEmpty) {
          return FutureBuilder<String>(
            future: () async {
              if (p.isAbsolute(localUri)) return localUri;
              final appDocDir = await getApplicationDocumentsDirectory();
              return p.join(appDocDir.path, localUri);
            }(),
            builder: (context, pathSnapshot) {
              if (!pathSnapshot.hasData) return const SizedBox();
              
              final absolutePath = pathSnapshot.data!;
              final file = File(absolutePath);
              
              if (file.existsSync()) {
                return Image.file(
                  file,
                  height: height,
                  width: width,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      ImageResources.emptyPdf,
                      fit: fit,
                      height: height,
                      width: width,
                    );
                  },
                );
              } else {
                return _buildPlaceholderOrSyncing(state);
              }
            },
          );
        }

        return _buildPlaceholderOrSyncing(state);
      },
    );
  }

  Widget _buildPlaceholderOrSyncing(int? state) {
    if (state == 1) {
      // QUEUED_DOWNLOAD
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            ImageResources.emptyPdf,
            fit: fit,
            height: height,
            width: width,
          ),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      );
    }

    return Image.asset(
      ImageResources.emptyPdf,
      fit: fit,
      height: height,
      width: width,
    );
  }
}
