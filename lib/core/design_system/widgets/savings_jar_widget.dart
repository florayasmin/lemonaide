import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../tokens/app_shadows.dart';

/// Savings goal visualized as a filling lemonade jar.
class SavingsJarWidget extends StatelessWidget {
  const SavingsJarWidget({
    required this.title,
    required this.savedCents,
    required this.targetCents,
    this.emoji,
    this.cupCount = 6,
    super.key,
  });

  final String title;
  final int savedCents;
  final int targetCents;
  final String? emoji;
  final int cupCount;

  double get _progress =>
      targetCents > 0 ? (savedCents / targetCents).clamp(0.0, 1.0) : 0;

  int get _filledCups => (_progress * cupCount).round();

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: r'$');
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            if (emoji != null) ...[
              Text(emoji!, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    '${currency.format(savedCents / 100)} / '
                    '${currency.format(targetCents / 100)}',
                    style: AppTextStyles.captionMuted(context),
                  ),
                ],
              ),
            ),
            Text(
              '${(_progress * 100).round()}%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: AppSpacing.jarHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _JarOutline(isDark: isDark),
              ClipPath(
                clipper: _JarClipper(),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: _progress,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.jarFillGradient,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.2, end: 0, duration: 500.ms),
                ),
              ),
              Positioned(
                top: AppSpacing.sm,
                child: Icon(
                  Icons.local_drink_rounded,
                  size: 28,
                  color: AppColors.blue.withValues(alpha: 0.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < cupCount; i++)
              Icon(
                Icons.local_drink_rounded,
                size: 26,
                color: i < _filledCups
                    ? AppColors.lemonYellow
                    : AppColors.skyBlue.withValues(alpha: 0.35),
              )
                  .animate(delay: (i * 60).ms)
                  .scale(
                    begin: i < _filledCups
                        ? const Offset(0.5, 0.5)
                        : const Offset(1, 1),
                    end: const Offset(1, 1),
                    duration: 300.ms,
                    curve: Curves.elasticOut,
                  ),
          ],
        ),
      ],
    );
  }
}

class _JarOutline extends StatelessWidget {
  const _JarOutline({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: AppSpacing.jarHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        border: Border.all(
          color: AppColors.border(isDark),
          width: 2.5,
        ),
        color: AppColors.skyBlue.withValues(alpha: isDark ? 0.08 : 0.18),
        boxShadow: AppShadows.soft(isDark: isDark),
      ),
    );
  }
}

class _JarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, size.width, size.height),
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: const Radius.circular(28),
          bottomRight: const Radius.circular(28),
        ),
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
