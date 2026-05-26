import 'package:flutter/material.dart';

import '../../../../core/design_system/tokens/wireframe_styles.dart';

/// Shared thick-outline styling for dashboard panels (wireframe style).
abstract final class DashboardPanelStyles {
  static const borderWidth = WireframeStyles.borderWidth;

  static BoxDecoration boxDecoration({Color? color}) =>
      WireframeStyles.boxDecoration(color: color);

  static TextStyle titleStyle(BuildContext context) =>
      WireframeStyles.titleStyle(context);

  static TextStyle labelStyle(BuildContext context) =>
      WireframeStyles.labelStyle(context);

  static TextStyle valueStyle(BuildContext context) =>
      WireframeStyles.valueStyle(context);

  static TextStyle actionLabelStyle(BuildContext context) =>
      WireframeStyles.buttonLabelStyle(context);
}
