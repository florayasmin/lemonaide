import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../foundation/lemon_interactive.dart';
import '../tokens/wireframe_styles.dart';

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    required this.label,
    this.icon = Icons.emoji_events_rounded,
    this.unlocked = false,
    this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool unlocked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = unlocked ? AppColors.lemonYellow : AppColors.creamSurface;
    final iconColor =
        unlocked ? AppColors.slate : AppColors.slate.withValues(alpha: 0.35);

    Widget badge = Container(
      width: AppSpacing.badgeSize + 16,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      decoration: WireframeStyles.boxDecoration(color: bg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            unlocked ? icon : Icons.lock_rounded,
            color: iconColor,
            size: AppSpacing.iconLg,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: WireframeStyles.buttonLabelStyle(context, fontSize: 14),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    if (onTap != null && unlocked) {
      badge = LemonInteractive(onTap: onTap, child: badge);
    }

    return badge
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1, 1),
          curve: Curves.elasticOut,
          duration: 450.ms,
        );
  }
}
