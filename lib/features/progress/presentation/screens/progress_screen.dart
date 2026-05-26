import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/state/lemonaide_notifier.dart';
import '../../../home/presentation/providers/dashboard_provider.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = AppSpacing.screenPadding(context);
    final dashboard = ref.watch(dashboardProvider);
    final appState = ref.watch(lemonaideProvider);
    final level = appState.standLevel;

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
                  title: AppStrings.progressTitle,
                  subtitle: AppStrings.progressSubtitle,
                ),
                SizedBox(height: AppSpacing.sectionGap(context)),
                WireframeLevelCard(
                  title: 'Lemonade stand',
                  subtitle: level >= 3
                      ? 'Your stand is booming!'
                      : 'Earn more to grow your stand!',
                  levelLabel: 'Level $level',
                ),
                const SizedBox(height: AppSpacing.lg),
                WireframePanel(
                  backgroundColor: AppColors.mintGreen,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        size: 40,
                        color: AppColors.slate,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${dashboard.streakDays}-day streak',
                              style: WireframeStyles.titleStyle(context),
                            ),
                            const SizedBox(height: AppSpacing.xxs),
                            Text(
                              'Keep logging earnings to build your streak!',
                              style: WireframeStyles.labelStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Achievements',
                  style: WireframeStyles.titleStyle(context),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AchievementBadge(
                      label: 'First \$5',
                      unlocked: appState.hasFirstFiveDollars,
                    ),
                    AchievementBadge(
                      label: 'Saver',
                      unlocked: appState.isSaver,
                    ),
                    AchievementBadge(
                      label: 'Boss',
                      unlocked: appState.isBoss,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
