import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/state/lemonaide_notifier.dart';
import '../widgets/create_goal_sheet.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = AppSpacing.screenPadding(context);
    final appState = ref.watch(lemonaideProvider);
    final goals = [...appState.goals]
      ..sort((a, b) {
        if (a.id == appState.activeGoalId) return -1;
        if (b.id == appState.activeGoalId) return 1;
        return b.createdAt.compareTo(a.createdAt);
      });

    return ColoredBox(
      color: AppColors.cream,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          padding,
          AppSpacing.md,
          padding,
          AppSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const WireframePageHeader(
                  title: AppStrings.goalsTitle,
                  subtitle: AppStrings.goalsSubtitle,
                ),
                SizedBox(height: AppSpacing.sectionGap(context)),
                Text(
                  'Your goals',
                  style: WireframeStyles.titleStyle(context),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Earnings go toward your active goal. Tap a goal to switch.',
                  style: WireframeStyles.pageSubtitleStyle(context),
                ),
                const SizedBox(height: AppSpacing.md),
                for (final goal in goals) ...[
                  WireframeGoalCard(
                    title: goal.title,
                    savedCents: goal.savedCents,
                    targetCents: goal.targetCents,
                    emoji: goal.emoji,
                    isActive: goal.id == appState.activeGoalId,
                    onTap: goal.id == appState.activeGoalId
                        ? null
                        : () {
                            ref
                                .read(lemonaideProvider.notifier)
                                .setActiveGoal(goal.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${goal.title} is now active'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                    onDelete: goals.length > 1
                        ? () => _confirmDelete(context, ref, goal.title, goal.id)
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                LemonButton(
                  label: 'Create a goal',
                  icon: Icons.flag_rounded,
                  size: LemonButtonSize.lg,
                  variant: LemonButtonVariant.mint,
                  expand: true,
                  onPressed: () => CreateGoalSheet.show(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String title,
    String goalId,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cream,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.slate, width: 3.5),
        ),
        title: Text('Remove goal?', style: WireframeStyles.titleStyle(context)),
        content: Text(
          'Delete "$title"? This cannot be undone.',
          style: WireframeStyles.labelStyle(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: WireframeStyles.labelStyle(context),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(lemonaideProvider.notifier).deleteGoal(goalId);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: WireframeStyles.labelStyle(context).copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
