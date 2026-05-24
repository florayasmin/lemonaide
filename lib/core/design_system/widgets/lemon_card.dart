import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../foundation/lemon_interactive.dart';
import '../tokens/app_motion.dart';
import '../tokens/app_shadows.dart';

class LemonCard extends StatelessWidget {
  const LemonCard({
    required this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.animateEntrance = true,
    this.accent,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool animateEntrance;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ?? AppColors.surface(isDark);
    final border = borderColor ?? AppColors.border(isDark);
    final radius = AppSpacing.borderRadius(AppSpacing.radiusLg);

    Widget card = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: AppShadows.soft(isDark: isDark),
      ),
      child: Material(
        color: bg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: border, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: accent != null
            ? Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(width: 5, color: accent),
                  ),
                  _cardBody(context, radius),
                ],
              )
            : _cardBody(context, radius),
      ),
    );

    if (onTap != null) {
      card = LemonInteractive(onTap: onTap, child: card);
    }

    if (animateEntrance) {
      card = AppMotion.entranceFadeSlide(card);
    }

    return card;
  }

  Widget _cardBody(BuildContext context, BorderRadius radius) {
    final body = Padding(
      padding: padding ?? AppSpacing.cardPadding(context),
      child: child,
    );

    if (onTap == null) return body;

    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      splashColor: AppColors.blue.withValues(alpha: 0.12),
      highlightColor: AppColors.hoverOverlay(
        Theme.of(context).brightness == Brightness.dark,
      ),
      child: body,
    );
  }
}

/// Stat highlight card used on dashboards.
class LemonStatCard extends StatelessWidget {
  const LemonStatCard({
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

    return LemonCard(
      backgroundColor: accent.withValues(alpha: 0.12),
      borderColor: accent.withValues(alpha: 0.35),
      accent: accent,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.22),
              borderRadius: AppSpacing.borderRadius(AppSpacing.radiusMd),
            ),
            child: Icon(icon, color: accent, size: AppSpacing.iconLg),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.06, 1.06),
                duration: 1800.ms,
                curve: Curves.easeInOut,
              ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.captionMuted(context)),
                Text(value, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
