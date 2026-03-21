import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/common/image_resources.dart';
import 'package:docguard/common/widgets/empty_state.dart';
import 'package:docguard/common/widgets/shimmer_loading.dart';
import 'package:docguard/features/documents/presentation/blocs/document_bloc.dart';
import 'package:docguard/features/documents/presentation/blocs/document_state.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/presentation/widgets/document_list_card.dart';
import 'package:docguard/features/documents/presentation/widgets/document_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:docguard/core/navigation/app_router.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state.status == DocumentSyncStatus.inProgress &&
              state.documents.isEmpty) {
            return const HomeShimmer();
          }

          final recentDocs = state.documents.toList()
            ..sort(
              (a, b) => b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0,
            );
          final favoriteDocs = state.favoriteDocuments.toList()
            ..sort(
              (a, b) => b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0,
            );

          return recentDocs.isEmpty
              ? const EmptyState(
                  title: 'No documents found',
                  subTitle:
                      'Scan your first document to get started by tapping the scan button below',
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Documents',
                        style: AppTypography.bodyXlBold.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (recentDocs.isEmpty)
                        const Text('No documents found. Scan to add one!'),
                      if (recentDocs.isNotEmpty)
                        SizedBox(
                          height: 196,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: recentDocs.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              return _buildDocCard(
                                context,
                                recentDocs[index],
                                state,
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 32),
                      Text(
                        'Favorite Documents',
                        style: AppTypography.bodyXlBold.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (favoriteDocs.isEmpty)
                        const EmptyState(
                          title: 'No favorite documents yet.',
                          showArrow: false,
                          subTitle:
                              'Tap the star icon on any document to add it to your favorites',
                        ),
                      if (favoriteDocs.isNotEmpty)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: favoriteDocs.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return DocumentListCard(doc: favoriteDocs[index]);
                          },
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildDocCard(
    BuildContext context,
    DocumentEntity doc,
    DocumentState state,
  ) {
    final title = doc.docNumber?.isNotEmpty == true
        ? doc.docNumber!
        : 'Scanned Document';

    return InkWell(
      onTap: () {
        context.push(AppRouter.pdfViewer, extra: doc);
      },
      child: Container(
        height: 196,
        width: 165,
        decoration: BoxDecoration(
          color: AppColors.primary25.withAlpha(150),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  DocumentThumbnail(
                    thumbnailUrl: doc.thumbnailUrl,
                    height: 127,
                    width: double.infinity,
                  ),
                  if (!doc.aiProcessed)
                    Positioned.fill(
                      child: Lottie.asset(
                        ImageResources.sparkleLottie,
                        fit: BoxFit.cover,
                        repeat: true,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: Text(
                title,
                style: AppTypography.bodyMRegular.copyWith(
                  color: AppColors.grey800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                doc.updatedAt != null && doc.updatedAt != doc.createdAt
                    ? 'Last update ${DateFormat('hh.mma').format(doc.updatedAt!).toLowerCase()}'
                    : 'Added ${doc.createdAt != null ? DateFormat('dd.MM.yyyy').format(doc.createdAt!) : ''}',
                style: AppTypography.bodySRegular.copyWith(
                  color: AppColors.grey25,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
    // Card(
    //   margin: const EdgeInsets.only(bottom: 12),
    //   elevation: 2,
    //   child: ListTile(
    //     leading: _buildThumbnail(doc.thumbnailUrl),
    //     title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    //     subtitle: Text(
    //       isProcessing
    //           ? 'Mastra AI is extracting data...'
    //           : 'Processed successfully',
    //     ),
    //     trailing: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         IconButton(
    //           icon: Icon(
    //             doc.isFavorite ? Icons.favorite : Icons.favorite_border,
    //             color: doc.isFavorite ? Colors.red : Colors.grey,
    //           ),
    //           onPressed: () {
    //             BlocProvider.of<DocumentBloc>(
    //               context,
    //               listen: false,
    //             ).add(DocumentEvent.favoriteToggled(doc.id, !doc.isFavorite));
    //           },
    //         ),
    //         if (isProcessing)
    //           const SizedBox(
    //             width: 20,
    //             height: 20,
    //             child: CircularProgressIndicator(strokeWidth: 2),
    //           )
    //         else
    //           const Icon(Icons.check_circle, color: Colors.green),
    //       ],
    //     ),
    //   ),
    // );
  }
}
