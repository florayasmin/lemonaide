import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../spacing/app_spacing.dart';
import 'bounce_tap.dart';

enum AppButtonVariant {
  /// Yellow background, blue text — primary CTA.
  lemon,

  /// Blue background, white/cream text — secondary CTA.
  sky,

  /// Outlined, subtle — tertiary actions.
  ghost,
}

enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.lemon,
    this.size = AppButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = _colorsFor(variant, context);
    final padding = _paddingFor(size);
    final fontSize = switch (size) {
      AppButtonSize.sm => 14.0,
      AppButtonSize.md => 16.0,
      AppButtonSize.lg => 18.0,
    };

    final enabled = onPressed != null && !isLoading;

    final child = Material(
      color: bg,
      elevation: 0,
      shadowColor: AppColors.lightShadow,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
        side: border ?? BorderSide.none,
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.slate.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: fontSize,
                height: fontSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: fg,
                ),
              )
            else ...[
              if (icon != null) ...[
                Icon(icon, color: fg, size: fontSize + 4),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: fg,
                      fontSize: fontSize,
                    ),
              ),
            ],
          ],
        ),
      ),
    );

    final button = BounceTap(
      enabled: enabled,
      onTap: enabled ? onPressed : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: child,
      ),
    );

    if (expand) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  (Color bg, Color fg, BorderSide? border) _colorsFor(
    AppButtonVariant variant,
    BuildContext context,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return switch (variant) {
      AppButtonVariant.lemon => (
          AppColors.lemonYellow,
          AppColors.blue,
          null,
        ),
      AppButtonVariant.sky => (
          AppColors.blue,
          isDark ? AppColors.darkBackground : AppColors.cream,
          null,
        ),
      AppButtonVariant.ghost => (
          Colors.transparent,
          Theme.of(context).colorScheme.onSurface,
          BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
          ),
        ),
    };
  }

  EdgeInsets _paddingFor(AppButtonSize size) => switch (size) {
        AppButtonSize.sm => const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
        AppButtonSize.md => const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        AppButtonSize.lg => const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
      };
}
