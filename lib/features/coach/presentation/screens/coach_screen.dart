import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/widgets/placeholder_screen.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  static const _starters = [
    'What is profit?',
    'Should I save or spend?',
    'How do I set a price?',
    'What is a budget?',
  ];

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppStrings.coachTitle,
      subtitle: AppStrings.coachSubtitle,
      children: [
        LemonCard(
          backgroundColor: AppColors.skyBlue.withValues(alpha: 0.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.blue,
                child: Icon(Icons.waving_hand_rounded, color: AppColors.cream),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  "Hey! I'm your Lemonaide coach — like a friendly older sibling who loves business. What did you earn today?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Try asking:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final prompt in _starters)
              LemonWireframeChip(
                label: prompt,
                icon: Icons.chat_bubble_outline_rounded,
                backgroundColor: AppColors.pastelYellow,
                onPressed: () {},
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        RoundedInputField(
          label: 'Ask your coach',
          hint: 'What is profit?',
          prefixIcon: Icons.chat_bubble_outline_rounded,
          maxLines: 2,
        ),
        const SizedBox(height: AppSpacing.md),
        LemonButton(
          label: 'Start conversation',
          variant: LemonButtonVariant.sky,
          icon: Icons.send_rounded,
          size: LemonButtonSize.lg,
          expand: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
