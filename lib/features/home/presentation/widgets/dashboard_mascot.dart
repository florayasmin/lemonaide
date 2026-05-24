import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Lemmy the lemonade mascot — friendly coach character.
class DashboardMascot extends StatelessWidget {
  const DashboardMascot({
    required this.message,
    required this.kidName,
    super.key,
  });

  final String message;
  final String kidName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MascotAvatar()
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .rotate(begin: -0.05, end: 0.05, duration: 2200.ms),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey $kidName! 👋',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.skyBlue.withValues(alpha: 0.35),
                  borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
                  border: Border.all(
                    color: AppColors.blue.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  message,
                  style: AppTextStyles.bodyLarge(
                    AppColors.onSurface(
                      Theme.of(context).brightness == Brightness.dark,
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms)
                  .slideX(begin: 0.08, end: 0, duration: 400.ms),
            ],
          ),
        ),
      ],
    );
  }
}

class _MascotAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        gradient: AppColors.lemonGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.lemonYellow.withValues(alpha: 0.45),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.local_drink_rounded,
            size: 36,
            color: AppColors.blue,
          ),
          Positioned(
            top: 10,
            right: 12,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.mintGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.7, 0.7),
          end: const Offset(1, 1),
          duration: 500.ms,
          curve: Curves.elasticOut,
        );
  }
}
