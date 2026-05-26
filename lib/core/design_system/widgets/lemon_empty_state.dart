import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../tokens/wireframe_styles.dart';
import 'lemon_button.dart';
import 'wireframe_panel.dart';

/// Friendly empty state for lists, goals, earnings, etc.
class LemonEmptyState extends StatelessWidget {
  const LemonEmptyState({
    required this.title,
    required this.message,
    this.icon = Icons.savings_outlined,
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
      child: WireframePanel(
        backgroundColor: AppColors.pastelYellow.withValues(alpha: 0.45),
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: AppColors.slate),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: WireframeStyles.titleStyle(context),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: WireframeStyles.labelStyle(context),
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
      ),
    );
  }
}
