import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

/// Hand-drawn earnings cup artwork (fill levels will be separate assets later).
class EarningsCup extends StatelessWidget {
  const EarningsCup({super.key});

  static double get _aspectRatio =>
      AppAssets.cupImageWidth / AppAssets.cupImageHeight;

  /// Slightly oversize so the cup feels hero-sized in the left column.
  static const _sizeBoost = 1.12;

  /// Optical centering — artwork reads a little top-right at true center.
  static const _alignmentNudge = Alignment(-0.20, 0.15);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        if (maxWidth <= 0 || maxHeight <= 0) {
          return const SizedBox.shrink();
        }

        // Fit within the box, then scale up a touch for visual weight.
        var width = maxWidth;
        var height = width / _aspectRatio;

        if (height > maxHeight) {
          height = maxHeight;
          width = height * _aspectRatio;
        }

        width *= _sizeBoost;
        height *= _sizeBoost;

        return SizedBox(
          width: maxWidth,
          height: maxHeight,
          child: Align(
            alignment: _alignmentNudge,
            child: Image.asset(
              AppAssets.lemonadeCup,
              width: width,
              height: height,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('Cup asset error: $error');
                return Icon(
                  Icons.local_drink_rounded,
                  size: width * 0.4,
                  color: AppColors.blue,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// Total earned label — sits in the bottom row beside the action buttons.
class TotalEarnedDisplay extends StatelessWidget {
  const TotalEarnedDisplay({required this.earnedCents, super.key});

  final int earnedCents;

  static const _labelFontSize = 22.0;
  static const _amountFontSize = 44.0;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: r'$');
    final earned = currency.format(earnedCents / 100);

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total earned',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.slate.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: _labelFontSize,
                ),
          ),
          Text(
            earned,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: _amountFontSize,
                ),
          ),
        ],
      ),
    );
  }
}
