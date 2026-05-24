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
