import 'package:flutter/material.dart';

import 'responsive_breakpoints.dart';

/// Consistent spacing scale used across the app.
abstract final class AppSpacing {
  static const double unit = 4;

  static const double xxs = unit; // 4
  static const double xs = unit * 2; // 8
  static const double sm = unit * 3; // 12
  static const double md = unit * 4; // 16
  static const double lg = unit * 5; // 20
  static const double xl = unit * 6; // 24
  static const double xxl = unit * 8; // 32
  static const double xxxl = unit * 10; // 40

  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusXl = 32;
  static const double radiusFull = 999;

  static const double navRailWidth = 72;
  static const double navRailWidthExtended = 200;
  static const double maxContentWidth = 720;

  /// Horizontal screen padding that grows on larger devices.
  static double screenPadding(BuildContext context) {
    if (context.isExpanded) return xl;
    if (context.isTablet) return lg;
    return md;
  }

  /// Vertical gap between major sections.
  static double sectionGap(BuildContext context) {
    if (context.isExpanded) return xxl;
    return xl;
  }

  /// Insets for cards and list tiles.
  static EdgeInsets cardPadding(BuildContext context) => EdgeInsets.all(
        context.isTablet ? lg : md,
      );

  static BorderRadius borderRadius([double? radius]) =>
      BorderRadius.circular(radius ?? radiusLg);
}
