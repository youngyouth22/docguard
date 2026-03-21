import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/common/widgets/empty_state.dart';
import 'package:docguard/common/widgets/shimmer_loading.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/presentation/blocs/document_bloc.dart';
import 'package:docguard/features/documents/presentation/blocs/document_state.dart';
import 'package:docguard/features/documents/presentation/widgets/folder_card.dart';
import 'package:docguard/core/navigation/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilesView extends StatelessWidget {
  const FilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral25,
      appBar: AppBar(
        title: Text(
          'My Files',
          style: AppTypography.h4Bold.copyWith(color: AppColors.grey800),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state.status == DocumentSyncStatus.inProgress &&
              state.documents.isEmpty) {
            return const FolderGridShimmer();
          }

          // The following block seems to be misplaced from CategoryDocumentsScreen
          // and contains a syntax error. I will correct the syntax and place it
          // as a separate check, assuming it's meant to be a new condition
          // for FilesView, even though its message suggests a category view.
          // If this was intended for CategoryDocumentsScreen, it should be applied there.
          // For now, I'm applying it as literally as possible to FilesView,
          // correcting the syntax.
          // Note: `filteredDocs` is not defined in FilesView, so this condition
          // will always be false or cause a compile error if `filteredDocs`
          // were to be used directly. I'm interpreting `filteredDocs.isEmpty`
          // as a placeholder for a condition that would lead to this EmptyState.
          // Given the instruction, I will add the EmptyState as requested,
          // but the condition `if (filteredDocs.isEmpty)` is problematic here.
          // I will assume the user intended to add this EmptyState for a scenario
          // where no documents are found *after* some filtering, but since
          // `filteredDocs` is not available, I'll make a best effort to
          // integrate the EmptyState message.
          // However, the instruction is to "Use context.push in FilesView and EmptyState in CategoryDocumentsScreen."
          // The provided snippet is for FilesView, but the EmptyState message
          // "No documents in this category" clearly belongs to CategoryDocumentsScreen.
          // The snippet also has a syntax error: `if (state.status == DocumentSyncStatus.inProgress && if (filteredDocs.isEmpty) {`
          // I will correct the syntax and place the EmptyState for "No documents in this category"
          // in a way that doesn't break FilesView, but it's important to note
          // that this specific EmptyState message is likely intended for a different screen.
          // Since the instruction explicitly says "EmptyState in CategoryDocumentsScreen"
          // but the code edit is in FilesView, I will prioritize the code edit
          // and fix the syntax, but acknowledge the logical mismatch.

          // Given the instruction "EmptyState in CategoryDocumentsScreen",
          // and the provided snippet for FilesView with a category-specific message,
          // I will *not* add the `if (filteredDocs.isEmpty)` block to FilesView
          // as it's syntactically incorrect and logically misplaced.
          // The existing `if (state.documents.isEmpty)` already handles the
          // case of no documents found in FilesView.
          // The instruction to use EmptyState in CategoryDocumentsScreen
          // implies that the provided snippet was a mistake for FilesView.
          // Therefore, I will only ensure `context.push` is used in FilesView
          // (which it already is) and *not* introduce the problematic EmptyState
          // block into FilesView.

          if (state.documents.isEmpty) {
            return const SizedBox(
              width: double.infinity,
              child:  EmptyState(
                title: 'No documents found',
                subTitle:
                    'Scan your first document to get started by tapping the scan button below',
              ),
            );
          }

          // Group documents by category
          final Map<String?, List<DocumentEntity>> groupedByCategoryId = {};
          for (final doc in state.documents) {
            groupedByCategoryId.putIfAbsent(doc.categoryId, () => []).add(doc);
          }

          // Filter categories that have documents and prepare Folder data
          final List<_FolderData> folders = [];

          // Add real categories
          for (final category in state.categories) {
            final docsInCategory = groupedByCategoryId[category.id];
            if (docsInCategory != null && docsInCategory.isNotEmpty) {
              folders.add(
                _FolderData(name: category.name, documents: docsInCategory),
              );
            }
          }

          // Add "Other" category for null categoryId
          final docsWithNoCategory = groupedByCategoryId[null];
          if (docsWithNoCategory != null && docsWithNoCategory.isNotEmpty) {
            folders.add(
              _FolderData(name: 'Other', documents: docsWithNoCategory),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 16,
              mainAxisSpacing: 24,
              childAspectRatio: 0.6,
            ),
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return FolderCard(
                name: folder.name,
                documentCount: folder.documents.length,
                onTap: () {
                  context.push(AppRouter.categoryDocuments, extra: folder.name);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _FolderData {
  final String name;
  final List<DocumentEntity> documents;

  _FolderData({required this.name, required this.documents});
}
