import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';

/// Thick-outline wireframe styling shared by dashboard panels and buttons.
abstract final class WireframeStyles {
  static const borderWidth = 3.5;

  static BoxDecoration boxDecoration({Color? color}) => BoxDecoration(
        color: color ?? AppColors.creamSurface,
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.slate, width: borderWidth),
      );

  static TextStyle pageTitleStyle(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium!.copyWith(
            color: AppColors.slate,
            fontWeight: FontWeight.w800,
            fontSize: 32,
          );

  static TextStyle pageSubtitleStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.slate.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          );

  static TextStyle titleStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.slate,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          );

  static TextStyle labelStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.slate,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          );

  static TextStyle valueStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.slate,
            fontWeight: FontWeight.w800,
            fontSize: 28,
          );

  static TextStyle buttonLabelStyle(
    BuildContext context, {
    double fontSize = 18,
  }) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.slate,
            fontWeight: FontWeight.w800,
            fontSize: fontSize,
          );
}
