import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/design_system.dart';
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
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final (label, icon, color) in _sources)
              LemonWireframeChip(
                label: label,
                icon: icon,
                backgroundColor: color,
                onPressed: () {},
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        RoundedInputField(
          label: 'Amount earned',
          hint: r'$0.00',
          prefixIcon: Icons.attach_money_rounded,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: AppSpacing.lg),
        LemonButton(
          label: 'Add earning',
          icon: Icons.add_rounded,
          size: LemonButtonSize.lg,
          expand: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
