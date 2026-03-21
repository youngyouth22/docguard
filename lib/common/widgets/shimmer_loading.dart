import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:docguard/common/app_colors.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 4,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBaseColor = baseColor ?? AppColors.neutral300;
    final effectiveHighlightColor = highlightColor ?? AppColors.neutral100;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: effectiveBaseColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1200.ms,
          color: effectiveHighlightColor,
          stops: [0.0, 0.5, 1.0],
        );
  }
}

class DocumentListShimmer extends StatelessWidget {
  const DocumentListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          height: 96,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              const ShimmerLoading(width: 72, height: 72, borderRadius: 2),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ShimmerLoading(width: 140, height: 16),
                    const SizedBox(height: 8),
                    const ShimmerLoading(width: 100, height: 12),
                    const SizedBox(height: 6),
                    const ShimmerLoading(width: 80, height: 12),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FolderGridShimmer extends StatelessWidget {
  const FolderGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        crossAxisSpacing: 16,
        mainAxisSpacing: 24,
        childAspectRatio: 0.6,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ShimmerLoading(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 12,
              ),
            ),
            const SizedBox(height: 12),
            const ShimmerLoading(width: 80, height: 14),
            const SizedBox(height: 6),
            const ShimmerLoading(width: 40, height: 12),
          ],
        );
      },
    );
  }
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading(width: 150, height: 24),
          const SizedBox(height: 16),
          SizedBox(
            height: 196,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) => const ShimmerLoading(
                width: 165,
                height: 196,
                borderRadius: 4,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const ShimmerLoading(width: 150, height: 24),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(12),
              height: 96,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: const Row(
                children: [
                  ShimmerLoading(width: 72, height: 72, borderRadius: 2),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerLoading(width: 140, height: 16),
                        SizedBox(height: 8),
                        ShimmerLoading(width: 100, height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
