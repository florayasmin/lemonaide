import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/placeholder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppStrings.homeTitle,
      subtitle: AppStrings.homeSubtitle,
      icon: Icons.home_rounded,
      accentColor: AppColors.pastelYellow,
      children: [
        const AppStatCard(
          label: 'Total saved',
          value: '\$0.00',
          icon: Icons.savings_rounded,
          accentColor: AppColors.mintGreen,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppStatCard(
                label: 'Streak',
                value: '0 days',
                icon: Icons.local_fire_department_rounded,
                accentColor: AppColors.lemonYellow,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppStatCard(
                label: 'Earned',
                value: '\$0.00',
                icon: Icons.paid_rounded,
                accentColor: AppColors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your coin jar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
                child: LinearProgressIndicator(
                  value: 0.15,
                  minHeight: 16,
                  backgroundColor: AppColors.skyBlue.withValues(alpha: 0.3),
                  color: AppColors.lemonYellow,
                  borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Keep earning to fill it up!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Log earnings',
          icon: Icons.add_rounded,
          expand: true,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Chat with coach',
          variant: AppButtonVariant.sky,
          icon: Icons.chat_rounded,
          expand: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
