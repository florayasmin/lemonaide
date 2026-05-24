import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';

/// Subtle floating lemonade decorations behind dashboard content.
class FloatingLemonadeDecor extends StatelessWidget {
  const FloatingLemonadeDecor({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          _FloatingIcon(
            icon: Icons.local_drink_rounded,
            color: AppColors.lemonYellow.withValues(alpha: 0.22),
            size: 48,
            top: 40,
            right: 24,
            delayMs: 0,
          ),
          _FloatingIcon(
            icon: Icons.local_drink_rounded,
            color: AppColors.skyBlue.withValues(alpha: 0.2),
            size: 32,
            top: 180,
            left: 12,
            delayMs: 400,
          ),
          _FloatingIcon(
            text: '🍋',
            size: 28,
            top: 320,
            right: 48,
            delayMs: 800,
          ),
          _FloatingIcon(
            icon: Icons.monetization_on_rounded,
            color: AppColors.coinGold.withValues(alpha: 0.18),
            size: 36,
            bottom: 120,
            left: 32,
            delayMs: 200,
          ),
          _FloatingIcon(
            icon: Icons.local_drink_rounded,
            color: AppColors.mintGreen.withValues(alpha: 0.25),
            size: 24,
            bottom: 280,
            right: 16,
            delayMs: 600,
          ),
        ],
      ),
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  const _FloatingIcon({
    this.icon,
    this.text,
    required this.size,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.color,
    this.delayMs = 0,
  });

  final IconData? icon;
  final String? text;
  final double size;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Color? color;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    final child = icon != null
        ? Icon(icon, size: size, color: color)
        : Text(text!, style: TextStyle(fontSize: size));

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(
            begin: 0,
            end: -10 - (delayMs % 3) * 2,
            duration: (2200 + delayMs).ms,
            curve: Curves.easeInOut,
          )
          .rotate(
            begin: -0.04,
            end: 0.04,
            duration: (2800 + delayMs).ms,
          ),
    )
        .animate(delay: delayMs.ms)
        .fadeIn(duration: 600.ms);
  }
}
