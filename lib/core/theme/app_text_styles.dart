import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Typography tokens — Quicksand/Fredoka can be wired via bundled fonts later.
abstract final class AppTextStyles {
  static TextTheme textTheme({required bool isDark}) {
    final onSurface = AppColors.onSurface(isDark);
    final base = isDark
        ? Typography.material2021().white
        : Typography.material2021().black;

    return base.copyWith(
      displayLarge: displayLarge(onSurface),
      displayMedium: displayMedium(onSurface),
      headlineLarge: headlineLarge(onSurface),
      headlineMedium: headlineMedium(onSurface),
      titleLarge: titleLarge(onSurface),
      titleMedium: titleMedium(onSurface),
      bodyLarge: bodyLarge(onSurface),
      bodyMedium: bodyMedium(onSurface),
      labelLarge: labelLarge(onSurface),
    );
  }

  // ── Theme-level styles ─────────────────────────────────────────────────

  static TextStyle displayLarge(Color onSurface) => TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: onSurface,
        letterSpacing: -0.5,
        height: 1.15,
      );

  static TextStyle displayMedium(Color onSurface) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: onSurface,
        height: 1.2,
      );

  static TextStyle headlineLarge(Color onSurface) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: onSurface,
      );

  static TextStyle headlineMedium(Color onSurface) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onSurface,
      );

  static TextStyle titleLarge(Color onSurface) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: onSurface,
      );

  static TextStyle titleMedium(Color onSurface) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: onSurface,
      );

  static TextStyle bodyLarge(Color onSurface) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: onSurface,
        height: 1.45,
      );

  static TextStyle bodyMedium(Color onSurface) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: onSurface.withValues(alpha: 0.88),
        height: 1.45,
      );

  static TextStyle labelLarge(Color onSurface) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: onSurface,
        letterSpacing: 0.3,
      );

  // ── Component styles ───────────────────────────────────────────────────

  static TextStyle button(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!;

  static TextStyle coinAmount(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.blue,
          );

  static TextStyle badgeLabel(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          );

  static TextStyle inputLabel(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          );

  static TextStyle captionMuted(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.onSurface(isDark).withValues(alpha: 0.65),
        );
  }

  static TextStyle emptyTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle emptyBody(BuildContext context) => captionMuted(context);
}
