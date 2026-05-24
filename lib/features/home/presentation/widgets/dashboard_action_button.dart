import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/design_system/foundation/lemon_interactive.dart';
import '../../../../core/spacing/app_spacing.dart';
import 'dashboard_panel_styles.dart';

/// Large wireframe-style action button with big icon + label.
class DashboardActionButton extends StatelessWidget {
  const DashboardActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LemonInteractive(
      onTap: onTap,
      child: Container(
        decoration: DashboardPanelStyles.boxDecoration(color: backgroundColor),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.lg,
          horizontal: AppSpacing.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 44, color: AppColors.slate),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: DashboardPanelStyles.actionLabelStyle(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
