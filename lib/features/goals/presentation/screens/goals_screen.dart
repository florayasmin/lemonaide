import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/widgets/placeholder_screen.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppStrings.goalsTitle,
      subtitle: AppStrings.goalsSubtitle,
      children: [
        LemonCard(
          child: SavingsJarWidget(
            title: 'New bike',
            savedCents: 4500,
            targetCents: 12000,
            emoji: '🚲',
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        LemonButton(
          label: 'Create a goal',
          icon: Icons.flag_rounded,
          size: LemonButtonSize.lg,
          variant: LemonButtonVariant.mint,
          expand: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
