import 'package:flutter/material.dart';

/// Breakpoints for responsive layout.
abstract final class ResponsiveBreakpoints {
  static const double tablet = 600;
  static const double expanded = 900;
  static const double wide = 1200;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isCompact => screenWidth < ResponsiveBreakpoints.tablet;

  bool get isTablet =>
      screenWidth >= ResponsiveBreakpoints.tablet &&
      screenWidth < ResponsiveBreakpoints.expanded;

  bool get isExpanded => screenWidth >= ResponsiveBreakpoints.expanded;

  bool get isWide => screenWidth >= ResponsiveBreakpoints.wide;

  /// Whether the left nav rail should show labels.
  bool get showNavLabels => screenWidth >= ResponsiveBreakpoints.tablet;
}
