import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/router/app_routes.dart';
import '../../../earnings/domain/entities/earning.dart';

class RecentEarningsSection extends StatelessWidget {
  const RecentEarningsSection({
    required this.earnings,
    super.key,
  });

  final List<Earning> earnings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recent earnings',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.earnings),
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        if (earnings.isEmpty)
          const LemonEmptyState(
            title: 'No earnings yet',
            message: 'Log your first sale or chore to get started!',
            icon: Icons.paid_outlined,
          )
        else
          ...earnings.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _EarningTile(
                    earning: entry.value,
                    index: entry.key,
                  ),
                ),
              ),
      ],
    );
  }
}

class _EarningTile extends StatelessWidget {
  const _EarningTile({
    required this.earning,
    required this.index,
  });

  final Earning earning;
  final int index;

  IconData get _sourceIcon => switch (earning.source) {
        EarningSource.lemonadeStand => Icons.local_drink_rounded,
        EarningSource.chores => Icons.cleaning_services_rounded,
        EarningSource.allowance => Icons.account_balance_wallet_rounded,
        EarningSource.babysitting => Icons.child_care_rounded,
        EarningSource.dogWalking => Icons.pets_rounded,
        EarningSource.other => Icons.paid_rounded,
      };

  Color get _sourceColor => switch (earning.source) {
        EarningSource.lemonadeStand => AppColors.lemonYellow,
        EarningSource.chores => AppColors.mintGreen,
        EarningSource.allowance => AppColors.skyBlue,
        EarningSource.babysitting => AppColors.blue,
        EarningSource.dogWalking => AppColors.pastelYellow,
        EarningSource.other => AppColors.slate,
      };

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: r'$');
    final date = DateFormat.MMMd().format(earning.earnedAt);

    return LemonCard(
      animateEntrance: false,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: _sourceColor.withValues(alpha: 0.4),
              borderRadius: AppSpacing.borderRadius(AppSpacing.radiusMd),
            ),
            child: Icon(_sourceIcon, color: AppColors.slate, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  earning.source.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                      ),
                ),
                Text(
                  earning.note ?? date,
                  style: AppTextStyles.captionMuted(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            '+${currency.format(earning.amountDollars)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    )
        .animate(delay: (80 * index).ms)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.06, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }
}
