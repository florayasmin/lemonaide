import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/widgets/placeholder_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppStrings.progressTitle,
      subtitle: AppStrings.progressSubtitle,
      children: [
        LemonCard(
          child: Column(
            children: [
              Icon(
                Icons.storefront_rounded,
                size: 64,
                color: AppColors.blue.withValues(alpha: 0.6),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Lemonade stand — Level 1',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Earn more to grow your stand!',
                style: AppTextStyles.captionMuted(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            AchievementBadge(label: 'First \$5', unlocked: true),
            AchievementBadge(label: 'Saver'),
            AchievementBadge(label: 'Boss'),
          ],
        ),
      ],
    );
  }
}
