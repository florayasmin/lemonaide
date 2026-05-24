import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Shared animation timings and curves for microinteractions.
abstract final class AppMotion {
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration normal = Duration(milliseconds: 280);
  static const Duration slow = Duration(milliseconds: 420);
  static const Duration entrance = Duration(milliseconds: 360);

  static const Curve bounce = Curves.elasticOut;
  static const Curve smooth = Curves.easeOutCubic;
  static const Curve playful = Curves.easeOutBack;

  static const double tapScale = 0.94;
  static const double hoverScale = 1.03;

  static Animate entranceFadeSlide(Widget child, {int delayMs = 0}) => child
      .animate(delay: delayMs.ms)
      .fadeIn(duration: entrance, curve: smooth)
      .slideY(begin: 0.08, end: 0, duration: entrance, curve: smooth);

  static Animate shimmer(Widget child) => child.animate(
        onPlay: (controller) => controller.repeat(),
      ).shimmer(
        duration: 1400.ms,
        color: const Color(0x55FFFFFF),
      );
}
