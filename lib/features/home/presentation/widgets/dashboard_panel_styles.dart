import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/design_system/tokens/wireframe_styles.dart';

/// Shared thick-outline styling for dashboard panels (wireframe style).
abstract final class DashboardPanelStyles {
  static const borderWidth = WireframeStyles.borderWidth;

  static BoxDecoration boxDecoration({Color? color}) =>
      WireframeStyles.boxDecoration(color: color);

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

  static TextStyle actionLabelStyle(BuildContext context) =>
      WireframeStyles.buttonLabelStyle(context);
}
