import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/placeholder_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppStrings.progressTitle,
      subtitle: AppStrings.progressSubtitle,
      icon: Icons.emoji_events_rounded,
      accentColor: AppColors.lemonYellow,
      children: [
        AppCard(
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(child: _BadgeTile(locked: false, label: 'First \$5')),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _BadgeTile(locked: true, label: 'Saver')),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _BadgeTile(locked: true, label: 'Boss')),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const ComingSoonCard(
          message:
              'Streaks, badges, and stand growth animations will unlock as kids earn.',
        ),
      ],
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.locked, required this.label});

  final bool locked;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      animate: false,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      backgroundColor: locked
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : AppColors.pastelYellow.withValues(alpha: 0.4),
      child: Column(
        children: [
          Icon(
            locked ? Icons.lock_rounded : Icons.emoji_events_rounded,
            color: locked
                ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35)
                : AppColors.blue,
            size: 32,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
