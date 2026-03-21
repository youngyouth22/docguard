import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/common/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showArrow;
  const EmptyState({
    super.key,
    required this.title,
    required this.subTitle,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Image.asset(ImageResources.emptyState, fit: BoxFit.cover),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.bodyXlMedium.copyWith(
              color: AppColors.grey800,
            ),
          ),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: subTitle,
                style: AppTypography.bodyMRegular.copyWith(
                  color: AppColors.grey500,
                ),
                children: showArrow ? [
                  WidgetSpan(
                    child: SvgPicture.asset(
                      ImageResources.arrow,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ] : [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
