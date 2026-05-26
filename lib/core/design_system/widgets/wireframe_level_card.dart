import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../tokens/wireframe_styles.dart';
import 'wireframe_panel.dart';

/// Lemonade stand level card for the Progress screen.
class WireframeLevelCard extends StatelessWidget {
  const WireframeLevelCard({
    required this.title,
    required this.subtitle,
    this.icon = Icons.storefront_rounded,
    this.levelLabel = 'Level 1',
    this.backgroundColor = AppColors.skyBlue,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String levelLabel;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return WireframePanel(
      backgroundColor: backgroundColor.withValues(alpha: 0.55),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          Icon(icon, size: 56, color: AppColors.slate),
          const SizedBox(height: AppSpacing.md),
          Text(title, style: WireframeStyles.titleStyle(context)),
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: WireframeStyles.boxDecoration(color: AppColors.lemonYellow),
            child: Text(
              levelLabel,
              style: WireframeStyles.buttonLabelStyle(context, fontSize: 16),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: WireframeStyles.labelStyle(context),
          ),
        ],
      ),
    );
  }
}
