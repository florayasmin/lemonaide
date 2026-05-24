import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/design_system/foundation/lemon_interactive.dart';
import '../../../../core/design_system/tokens/wireframe_styles.dart';

/// Triangular page-turn button for the coach storybook.
class StoryNavButton extends StatelessWidget {
  const StoryNavButton({
    required this.pointingRight,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  final bool pointingRight;
  final VoidCallback? onPressed;
  final bool enabled;

  static const _width = 56.0;
  static const _height = 48.0;

  @override
  Widget build(BuildContext context) {
    final color = enabled ? AppColors.lemonYellow : AppColors.pastelYellow;

    return LemonInteractive(
      enabled: enabled,
      onTap: onPressed,
      child: SizedBox(
        width: _width,
        height: _height,
        child: CustomPaint(
          painter: _TrianglePainter(
            color: color,
            pointingRight: pointingRight,
            enabled: enabled,
          ),
        ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  const _TrianglePainter({
    required this.color,
    required this.pointingRight,
    required this.enabled,
  });

  final Color color;
  final bool pointingRight;
  final bool enabled;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    if (pointingRight) {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, size.height / 2)
        ..lineTo(0, size.height)
        ..close();
    } else {
      path
        ..moveTo(size.width, 0)
        ..lineTo(0, size.height / 2)
        ..lineTo(size.width, size.height)
        ..close();
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.slate.withValues(alpha: enabled ? 1 : 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = WireframeStyles.borderWidth
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.pointingRight != pointingRight ||
        oldDelegate.enabled != enabled;
  }
}
