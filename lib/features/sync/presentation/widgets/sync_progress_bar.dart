import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:docguard/features/sync/presentation/bloc/sync_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncProgressBar extends StatelessWidget {
  const SyncProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncBloc, SyncState>(
      builder: (context, state) {
        final isSyncing = state.status?.downloading == true;
        final isDownloading = state.isDownloadingAttachments;
        final showProgress = isSyncing || isDownloading;

        if (!showProgress) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          color: AppColors.primary400.withValues(alpha: 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary400),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'We are synchronizing your documents...',
                        style: AppTypography.bodySMedium.copyWith(
                          color: AppColors.primary400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const LinearProgressIndicator(
                backgroundColor: AppColors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary400),
                minHeight: 2,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: -1, end: 0, curve: Curves.easeOutQuad);
      },
    );
  }
}
