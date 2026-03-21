import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/common/widgets/shimmer_loading.dart';
import 'package:docguard/features/documents/presentation/blocs/document_bloc.dart';
import 'package:docguard/features/documents/presentation/blocs/document_state.dart';
import 'package:docguard/features/documents/presentation/widgets/document_list_card.dart';
import 'package:docguard/common/widgets/empty_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDocumentsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDocumentsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral25,

      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Text(categoryName, style: AppTypography.h6Bold),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state.status == DocumentSyncStatus.inProgress &&
              state.documents.isEmpty) {
            return const DocumentListShimmer();
          }

          // Filter documents for this category
          final filteredDocs = state.documents.where((doc) {
            if (categoryName == 'Other') {
              return doc.categoryId == null;
            }
            // Find category ID by name
            final category = state.categories
                .where((c) => c.name == categoryName)
                .firstOrNull;
            return doc.categoryId == category?.id;
          }).toList();

          if (filteredDocs.isEmpty) {
            return const EmptyState(
              title: 'No documents in this category',
              subTitle: 'Add documents to this category to see them here',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filteredDocs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return DocumentListCard(doc: filteredDocs[index]);
            },
          );
        },
      ),
    );
  }
}
