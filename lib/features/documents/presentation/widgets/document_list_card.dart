import 'package:docguard/common/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/presentation/widgets/document_thumbnail.dart';
import 'package:docguard/features/documents/presentation/widgets/favorite_toggle.dart';
import 'package:docguard/core/utils/file_utils.dart';

import 'package:go_router/go_router.dart';
import 'package:docguard/core/navigation/app_router.dart';

class DocumentListCard extends StatelessWidget {
  final DocumentEntity doc;
  final VoidCallback? onTap;

  const DocumentListCard({super.key, required this.doc, this.onTap});

  @override
  Widget build(BuildContext context) {
    final title = doc.docNumber?.isNotEmpty == true
        ? doc.docNumber!
        : 'Scanned Document';

    return GestureDetector(
      onTap: onTap ?? () => context.push(AppRouter.pdfViewer, extra: doc),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        height: 96,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: AppColors.neutral400),
                ),
                child: Stack(
                  children: [
                    DocumentThumbnail(thumbnailUrl: doc.thumbnailUrl),
                    if (!doc.aiProcessed)
                      Positioned.fill(
                        child: Lottie.asset(
                          ImageResources.sparkleLottie,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLSemiBold.copyWith(
                      color: AppColors.grey800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${doc.fileExtension?.toUpperCase() ?? 'PDF'} • ${FileUtils.formatFileSize(doc.fileSize)}',
                    style: AppTypography.bodySRegular.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doc.createdAt != null
                        ? DateFormat(
                            'dd/MM/yyyy • HH:mm',
                          ).format(doc.createdAt!)
                        : 'N/A',
                    style: AppTypography.bodySRegular.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                ],
              ),
            ),
            // Favorite Toggle
            FavoriteToggle(documentId: doc.id, isFavorite: doc.isFavorite),
          ],
        ),
      ),
    );
  }
}
