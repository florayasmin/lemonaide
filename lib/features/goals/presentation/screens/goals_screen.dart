import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/placeholder_screen.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppStrings.goalsTitle,
      subtitle: AppStrings.goalsSubtitle,
      icon: Icons.savings_rounded,
      accentColor: AppColors.mintGreen,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.pedal_bike_rounded,
                    color: AppColors.blue,
                    size: 32,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New bike',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '\$0 / \$120',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _GoalCupRow(filledCups: 0, totalCups: 6),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Create a goal',
          icon: Icons.flag_rounded,
          expand: true,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.lg),
        const ComingSoonCard(
          message:
              'Goal jars visualized as filling lemonade cups — connect to Firestore next.',
        ),
      ],
    );
  }
}

/// Visualizes savings progress as a row of lemonade cups.
class _GoalCupRow extends StatelessWidget {
  const _GoalCupRow({
    required this.filledCups,
    required this.totalCups,
  });

  final int filledCups;
  final int totalCups;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < totalCups; i++)
          Icon(
            Icons.local_drink_rounded,
            size: 28,
            color: i < filledCups
                ? AppColors.lemonYellow
                : AppColors.skyBlue.withValues(alpha: 0.35),
          ),
      ],
    );
  }
}
