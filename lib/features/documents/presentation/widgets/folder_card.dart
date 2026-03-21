import 'package:flutter/material.dart';
import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';

class FolderCard extends StatelessWidget {
  final String name;
  final int documentCount;
  final VoidCallback onTap;

  const FolderCard({
    super.key,
    required this.name,
    required this.documentCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Apple-style Folder Shape
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: [
                // Back part of the folder (the tab)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 50,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.primary400.withValues(alpha: 0.8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(2),
                      ),
                    ),
                  ),
                ),
                // Main body of the folder
                Positioned.fill(
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary300, AppColors.primary400],
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary400.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.folder_rounded,
                        color: Colors.white.withValues(alpha: 0.2),
                        size: 48,
                      ),
                    ),
                  ),
                ),
                // Inner pocket effect
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  height: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                // Document count badge (optional, but nice)
                Positioned(
                  top: 16,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$documentCount',
                      style: AppTypography.bodyXsBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              name,
              style: AppTypography.bodyMMedium.copyWith(
                color: AppColors.grey700,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
