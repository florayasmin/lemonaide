import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../tokens/app_shadows.dart';

/// Animated coin + dollar display for earnings and balances.
class CoinCounter extends StatelessWidget {
  const CoinCounter({
    required this.amountCents,
    this.label,
    this.compact = false,
    this.animateEntrance = true,
    super.key,
  });

  final int amountCents;
  final String? label;
  final bool compact;
  final bool animateEntrance;

  @override
  Widget build(BuildContext context) {
    final dollars = amountCents / 100;
    final formatted = NumberFormat.currency(symbol: r'$').format(dollars);

  Widget row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CoinIcon(compact: compact),
        SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) ...[
              Text(label!, style: AppTextStyles.captionMuted(context)),
              const SizedBox(height: AppSpacing.xxs),
            ],
            Text(
              formatted,
              style: compact
                  ? Theme.of(context).textTheme.titleLarge
                  : AppTextStyles.coinAmount(context),
            ),
          ],
        ),
      ],
    );

    if (animateEntrance) {
      row = row
          .animate()
          .fadeIn(duration: 320.ms)
          .scale(
            begin: const Offset(0.92, 0.92),
            end: const Offset(1, 1),
            duration: 420.ms,
            curve: Curves.elasticOut,
          );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusXl),
        color: AppColors.pastelYellow.withValues(alpha: 0.45),
        boxShadow: AppShadows.glow(AppColors.coinGold),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? AppSpacing.md : AppSpacing.lg,
          vertical: compact ? AppSpacing.sm : AppSpacing.md,
        ),
        child: row,
      ),
    );
  }
}

class _CoinIcon extends StatelessWidget {
  const _CoinIcon({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 36.0 : 48.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.coinGold, AppColors.lemonYellow],
        ),
        boxShadow: AppShadows.soft(dy: 3),
      ),
      child: Icon(
        Icons.monetization_on_rounded,
        color: AppColors.blue,
        size: size * 0.62,
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .rotate(begin: -0.04, end: 0.04, duration: 2200.ms);
  }
}
