import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';
import '../spacing/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.animate = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.creamSurface);
    final border = borderColor ??
        (isDark
            ? AppColors.darkSurfaceHigh
            : AppColors.skyBlue.withValues(alpha: 0.35));

    Widget card = Material(
      color: bg,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
        side: BorderSide(color: border, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
        child: Padding(
          padding: padding ?? AppSpacing.cardPadding(context),
          child: child,
        ),
      ),
    );

    card = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppSpacing.borderRadius(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate.withValues(alpha: isDark ? 0.2 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: card,
    );

    if (animate) {
      card = card
          .animate()
          .fadeIn(duration: 280.ms, curve: Curves.easeOut)
          .slideY(begin: 0.06, end: 0, duration: 280.ms, curve: Curves.easeOut);
    }

    return card;
  }
}

/// Hero stat card for dashboard placeholders.
class AppStatCard extends StatelessWidget {
  const AppStatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.accentColor,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? AppColors.blue;

    return AppCard(
      backgroundColor: accent.withValues(alpha: 0.12),
      borderColor: accent.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.2),
              borderRadius: AppSpacing.borderRadius(AppSpacing.radiusMd),
            ),
            child: Icon(icon, color: accent, size: 28),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
