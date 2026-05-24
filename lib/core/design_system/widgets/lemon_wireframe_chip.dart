import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../foundation/lemon_interactive.dart';
import '../tokens/wireframe_styles.dart';

/// Compact wireframe chip — icon + label for filters, prompts, and sources.
class LemonWireframeChip extends StatelessWidget {
  const LemonWireframeChip({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    this.onPressed,
    super.key,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LemonInteractive(
      enabled: onPressed != null,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: WireframeStyles.boxDecoration(color: backgroundColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: AppColors.slate),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: WireframeStyles.buttonLabelStyle(context, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
