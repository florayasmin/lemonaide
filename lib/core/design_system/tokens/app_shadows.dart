import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Soft, kid-friendly elevation shadows.
abstract final class AppShadows {
  static List<BoxShadow> soft({bool isDark = false, double dy = 4}) => [
        BoxShadow(
          color: (isDark ? AppColors.darkShadow : AppColors.lightShadow)
              .withValues(alpha: isDark ? 0.35 : 1),
          blurRadius: 12,
          offset: Offset(0, dy),
        ),
      ];

  static List<BoxShadow> lifted({bool isDark = false}) => [
        BoxShadow(
          color: AppColors.slate.withValues(alpha: isDark ? 0.25 : 0.1),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: AppColors.blue.withValues(alpha: isDark ? 0.08 : 0.06),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> pressed({bool isDark = false}) => [
        BoxShadow(
          color: AppColors.slate.withValues(alpha: isDark ? 0.15 : 0.06),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> glow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 18,
          spreadRadius: -2,
          offset: const Offset(0, 4),
        ),
      ];
}
