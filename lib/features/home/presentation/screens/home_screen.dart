import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/state/earnings_input_provider.dart';
import '../../../earnings/domain/entities/earning.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_action_button.dart';
import '../widgets/dashboard_goal_box.dart';
import '../widgets/dashboard_stat_box.dart';
import '../widgets/dashboard_todo_box.dart';
import '../widgets/earnings_cup.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _rowGap = AppSpacing.sm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(dashboardProvider);
    final padding = AppSpacing.screenPadding(context);
    final currency = NumberFormat.currency(symbol: r'$');

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: _LeftPanel(earnedCents: d.totalEarnedCents),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: DashboardStatBox(
                          label: 'Current savings',
                          value: currency.format(d.currentSavingsCents / 100),
                          backgroundColor: AppColors.mintGreen,
                        ),
                      ),
                      const SizedBox(width: _rowGap),
                      Expanded(
                        child: DashboardStatBox(
                          label: 'This week',
                          value: currency.format(d.weekEarnedCents / 100),
                          backgroundColor: AppColors.skyBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: _rowGap),
                Expanded(
                  flex: 3,
                  child: DashboardTodoBox(todos: d.todos),
                ),
                const SizedBox(height: _rowGap),
                Expanded(
                  flex: 2,
                  child: DashboardGoalBox(goal: d.activeGoal),
                ),
                const SizedBox(height: _rowGap),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: DashboardActionButton(
                          label: 'Add earnings',
                          icon: Icons.add_rounded,
                          backgroundColor: AppColors.lemonYellow,
                          onTap: () => context.go(AppRoutes.earnings),
                        ),
                      ),
                      const SizedBox(width: _rowGap),
                      Expanded(
                        child: DashboardActionButton(
                          label: 'Log chore',
                          icon: Icons.cleaning_services_rounded,
                          backgroundColor: AppColors.mintGreen,
                          onTap: () {
                            ref.read(pendingEarningSourceProvider.notifier).state =
                                EarningSource.chores;
                            context.go(AppRoutes.earnings);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Cup centered in the upper area; total earned aligned with the action-button row.
class _LeftPanel extends StatelessWidget {
  const _LeftPanel({required this.earnedCents});

  final int earnedCents;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 7,
          child: EarningsCup(),
        ),
        const SizedBox(height: HomeScreen._rowGap),
        const SizedBox(height: HomeScreen._rowGap),
        const SizedBox(height: HomeScreen._rowGap),
        Expanded(
          flex: 3,
          child: TotalEarnedDisplay(earnedCents: earnedCents),
        ),
      ],
    );
  }
}
