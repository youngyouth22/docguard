import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child:
          Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign Out',
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.grey800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      'Are you sure you want to log out?\nYou will need to sign in again to access your documents.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMRegular.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(
                                color: AppColors.neutral700,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: AppTypography.bodyLMedium.copyWith(
                                color: AppColors.primary400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onLogout();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary400,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              'Logout',
                              style: AppTypography.bodyLMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .scale(
                duration: 400.ms,
                curve: Curves.easeOutBack,
                begin: const Offset(0.8, 0.8),
              )
              .fade(duration: 300.ms),
    );
  }

  /// Displays the logout dialog.
  static void show(BuildContext context, {required VoidCallback onLogout}) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => LogoutDialog(onLogout: onLogout),
    );
  }
}
