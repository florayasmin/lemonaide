import 'package:flutter/material.dart';

import 'responsive_breakpoints.dart';

/// Spacing, radii, durations, and layout constants.
abstract final class AppSpacing {
  static const double unit = 4;

  // ── Spacing scale ──────────────────────────────────────────────────────
  static const double xxs = unit;
  static const double xs = unit * 2;
  static const double sm = unit * 3;
  static const double md = unit * 4;
  static const double lg = unit * 5;
  static const double xl = unit * 6;
  static const double xxl = unit * 8;
  static const double xxxl = unit * 10;

  // ── Radii ────────────────────────────────────────────────────────────────
  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusXl = 32;
  static const double radiusFull = 999;

  // ── Component sizes ────────────────────────────────────────────────────
  static const double navRailWidth = 72;
  static const double navRailWidthExtended = 200;
  static const double maxContentWidth = 720;
  static const double buttonHeightMd = 52;
  static const double inputHeight = 56;
  static const double progressHeight = 18;
  static const double badgeSize = 72;
  static const double jarHeight = 140;
  static const double iconLg = 32;
  static const double iconMd = 24;

  // ── Durations (aliases for AppMotion) ──────────────────────────────────
  static const Duration durationFast = Duration(milliseconds: 180);
  static const Duration durationNormal = Duration(milliseconds: 280);
  static const Duration durationSlow = Duration(milliseconds: 420);

  static double screenPadding(BuildContext context) {
    if (context.isExpanded) return xl;
    if (context.isTablet) return lg;
    return md;
  }

  static double sectionGap(BuildContext context) {
    if (context.isExpanded) return xxl;
    return xl;
  }

  static EdgeInsets cardPadding(BuildContext context) => EdgeInsets.all(
        context.isTablet ? lg : md,
      );

  static BorderRadius borderRadius([double? radius]) =>
      BorderRadius.circular(radius ?? radiusLg);

  static EdgeInsets symmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
}
