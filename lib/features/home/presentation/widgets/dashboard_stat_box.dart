import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/spacing/app_spacing.dart';
import 'dashboard_panel_styles.dart';

/// Stat box — label + big dollar value.
class DashboardStatBox extends StatelessWidget {
  const DashboardStatBox({
    required this.label,
    required this.value,
    this.backgroundColor = AppColors.creamSurface,
    super.key,
  });

  final String label;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: DashboardPanelStyles.boxDecoration(color: backgroundColor),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: DashboardPanelStyles.labelStyle(context)),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(value, style: DashboardPanelStyles.valueStyle(context)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
