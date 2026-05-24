import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../goals/domain/entities/savings_goal.dart';
import 'dashboard_panel_styles.dart';

/// Goal progress bar panel.
class DashboardGoalBox extends StatelessWidget {
  const DashboardGoalBox({required this.goal, super.key});

  final SavingsGoal goal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: DashboardPanelStyles.boxDecoration(color: AppColors.pastelYellow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Goal progress', style: DashboardPanelStyles.titleStyle(context)),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
            child: Container(
              height: 22,
              decoration: BoxDecoration(
                color: AppColors.creamSurface,
                borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
                border: Border.all(
                  color: AppColors.slate,
                  width: DashboardPanelStyles.borderWidth,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                        width: constraints.maxWidth * goal.progress,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius:
                              AppSpacing.borderRadius(AppSpacing.radiusFull),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
