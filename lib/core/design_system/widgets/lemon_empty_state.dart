import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'lemon_button.dart';

/// Friendly empty state for lists, goals, earnings, etc.
class LemonEmptyState extends StatelessWidget {
  const LemonEmptyState({
    required this.title,
    required this.message,
    this.icon = Icons.local_drink_rounded,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.pastelYellow.withValues(alpha: 0.45),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: AppColors.blue),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(begin: 0, end: -6, duration: 1600.ms, curve: Curves.easeInOut),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: AppTextStyles.emptyTitle(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            style: AppTextStyles.emptyBody(context),
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: AppSpacing.lg),
            LemonButton(
              label: actionLabel!,
              icon: Icons.add_rounded,
              size: LemonButtonSize.lg,
              expand: true,
              onPressed: onAction,
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 360.ms).slideY(begin: 0.06, end: 0);
  }
}
