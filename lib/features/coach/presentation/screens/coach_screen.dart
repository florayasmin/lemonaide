import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
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
      icon: Icons.chat_bubble_rounded,
      accentColor: AppColors.skyBlue,
      children: [
        AppCard(
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
              ActionChip(
                label: Text(prompt),
                onPressed: () {},
                backgroundColor: AppColors.pastelYellow.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      AppSpacing.borderRadius(AppSpacing.radiusFull),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const ComingSoonCard(
          message:
              'Full AI chat with OpenAI, child-safe prompts, and conversation memory coming soon.',
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Start conversation',
          variant: AppButtonVariant.sky,
          icon: Icons.send_rounded,
          expand: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
