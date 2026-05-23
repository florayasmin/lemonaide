import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/placeholder_screen.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  static const _sources = [
    ('Lemonade stand', Icons.local_drink_rounded, AppColors.lemonYellow),
    ('Chores', Icons.cleaning_services_rounded, AppColors.mintGreen),
    ('Allowance', Icons.account_balance_wallet_rounded, AppColors.skyBlue),
    ('Babysitting', Icons.child_care_rounded, AppColors.blue),
    ('Dog walking', Icons.pets_rounded, AppColors.pastelYellow),
  ];

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppStrings.earningsTitle,
      subtitle: AppStrings.earningsSubtitle,
      icon: Icons.paid_rounded,
      accentColor: AppColors.mintGreen,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final (label, icon, color) in _sources)
              _SourceChip(label: label, icon: icon, color: color),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Add earning',
          icon: Icons.add_circle_outline_rounded,
          expand: true,
          onPressed: () {},
        ),
        const SizedBox(height: AppSpacing.lg),
        const ComingSoonCard(
          message:
              'Earnings history, photos, and categories will appear here in the next sprint.',
        ),
      ],
    );
  }
}

class _SourceChip extends StatelessWidget {
  const _SourceChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: AppColors.slate),
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.45),
      side: BorderSide(color: color.withValues(alpha: 0.6)),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
    );
  }
}
