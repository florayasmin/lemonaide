import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../foundation/lemon_interactive.dart';
import '../tokens/wireframe_styles.dart';

enum LemonButtonVariant { lemon, sky, mint, ghost }

enum LemonButtonSize { sm, md, lg }

class LemonButton extends StatelessWidget {
  const LemonButton({
    required this.label,
    this.onPressed,
    this.variant = LemonButtonVariant.lemon,
    this.size = LemonButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final LemonButtonVariant variant;
  final LemonButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final background = _backgroundFor(variant);
    final useColumnLayout = icon != null && (expand || size == LemonButtonSize.lg);
    final iconSize = switch (size) {
      LemonButtonSize.sm => 28.0,
      LemonButtonSize.md => 36.0,
      LemonButtonSize.lg => 44.0,
    };
    final fontSize = switch (size) {
      LemonButtonSize.sm => 14.0,
      LemonButtonSize.md => 16.0,
      LemonButtonSize.lg => 18.0,
    };
    final padding = switch (size) {
      LemonButtonSize.sm => const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      LemonButtonSize.md => const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
      LemonButtonSize.lg => const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.lg,
        ),
    };

    final labelStyle = WireframeStyles.buttonLabelStyle(
      context,
      fontSize: fontSize,
    );

    Widget content = AnimatedContainer(
      duration: AppSpacing.durationFast,
      padding: padding,
      decoration: WireframeStyles.boxDecoration(
        color: variant == LemonButtonVariant.ghost
            ? AppColors.creamSurface
            : background,
      ),
      child: isLoading
          ? Center(
              child: SizedBox(
                width: fontSize,
                height: fontSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.slate,
                ),
              ),
            )
          : useColumnLayout
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: iconSize, color: AppColors.slate),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      label,
                      style: labelStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: iconSize * 0.65, color: AppColors.slate),
                      const SizedBox(width: AppSpacing.xs),
                    ],
                    Flexible(
                      child: Text(
                        label,
                        style: labelStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
    );

    final button = LemonInteractive(
      enabled: enabled,
      onTap: onPressed,
      child: content,
    );

    if (expand) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Color _backgroundFor(LemonButtonVariant variant) => switch (variant) {
        LemonButtonVariant.lemon => AppColors.lemonYellow,
        LemonButtonVariant.sky => AppColors.skyBlue,
        LemonButtonVariant.mint => AppColors.mintGreen,
        LemonButtonVariant.ghost => AppColors.creamSurface,
      };
}
