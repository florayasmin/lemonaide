import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../foundation/lemon_interactive.dart';
import '../tokens/app_motion.dart';
import '../tokens/wireframe_styles.dart';

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
    final bg = backgroundColor ?? AppColors.creamSurface;
    final radius = AppSpacing.borderRadius(AppSpacing.radiusLg);

    Widget card = Container(
      decoration: WireframeStyles.boxDecoration(color: bg).copyWith(
        border: Border.all(
          color: borderColor ?? AppColors.slate,
          width: WireframeStyles.borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: radius,
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
    final accent = accentColor ?? AppColors.mintGreen;

    return LemonCard(
      backgroundColor: accent,
      child: Row(
        children: [
          Icon(icon, color: AppColors.slate, size: AppSpacing.iconLg),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: WireframeStyles.labelStyle(context)),
                Text(value, style: WireframeStyles.valueStyle(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
