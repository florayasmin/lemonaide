import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class LemonProgressBar extends StatelessWidget {
  const LemonProgressBar({
    required this.value,
    this.label,
    this.subtitle,
    this.height = AppSpacing.progressHeight,
    this.trackColor,
    this.fillColor,
    this.showPercent = false,
    super.key,
  });

  final double value;
  final String? label;
  final String? subtitle;
  final double height;
  final Color? trackColor;
  final Color? fillColor;
  final bool showPercent;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final track = trackColor ??
        AppColors.skyBlue.withValues(alpha: isDark ? 0.2 : 0.35);
    final fill = fillColor ?? AppColors.lemonYellow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null || showPercent)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                if (label != null)
                  Expanded(
                    child: Text(
                      label!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                if (showPercent)
                  Text(
                    '${(clamped * 100).round()}%',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.blue,
                        ),
                  ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
          child: SizedBox(
            height: height,
            child: Stack(
              children: [
                Container(color: track),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: clamped,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          fill,
                          fill.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .scaleX(
                        begin: 0,
                        end: 1,
                        duration: 600.ms,
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.centerLeft,
                      ),
                ),
              ],
            ),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle!, style: AppTextStyles.captionMuted(context)),
        ],
      ],
    );
  }
}
