import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../tokens/app_motion.dart';

/// Shimmer loading placeholder for cards, lists, and stats.
class LemonSkeleton extends StatelessWidget {
  const LemonSkeleton({
    this.width,
    this.height = 16,
    this.radius = AppSpacing.radiusMd,
    super.key,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? AppColors.darkSurfaceHigh : AppColors.skyBlue;

    return AppMotion.shimmer(
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base.withValues(alpha: isDark ? 0.35 : 0.25),
          borderRadius: AppSpacing.borderRadius(radius),
        ),
      ),
    );
  }
}

/// Full card-shaped loading skeleton.
class LemonCardSkeleton extends StatelessWidget {
  const LemonCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding(context),
      decoration: BoxDecoration(
        color: AppColors.surface(
          Theme.of(context).brightness == Brightness.dark,
        ),
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.border(
            Theme.of(context).brightness == Brightness.dark,
          ),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LemonSkeleton(width: 48, height: 48, radius: AppSpacing.radiusMd),
          SizedBox(height: AppSpacing.md),
          LemonSkeleton(width: 120, height: 14),
          SizedBox(height: AppSpacing.sm),
          LemonSkeleton(width: 80, height: 22),
        ],
      ),
    );
  }
}

/// List of skeleton rows for loading states.
class LemonListSkeleton extends StatelessWidget {
  const LemonListSkeleton({this.itemCount = 3, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < itemCount; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          const LemonCardSkeleton(),
        ],
      ],
    );
  }
}
