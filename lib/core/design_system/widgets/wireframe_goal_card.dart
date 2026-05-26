import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../foundation/lemon_interactive.dart';
import '../tokens/wireframe_styles.dart';
import 'wireframe_panel.dart';
import 'wireframe_progress_bar.dart';

/// Savings goal card for the Goals screen and home dashboard.
class WireframeGoalCard extends StatelessWidget {
  const WireframeGoalCard({
    required this.title,
    required this.savedCents,
    required this.targetCents,
    this.emoji,
    this.backgroundColor = AppColors.pastelYellow,
    this.isActive = false,
    this.onTap,
    this.onDelete,
    super.key,
  });

  final String title;
  final int savedCents;
  final int targetCents;
  final String? emoji;
  final Color backgroundColor;
  final bool isActive;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  double get _progress =>
      targetCents > 0 ? (savedCents / targetCents).clamp(0.0, 1.0) : 0.0;

  bool get _isComplete => savedCents >= targetCents;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: r'$');
    final saved = currency.format(savedCents / 100);
    final target = currency.format(targetCents / 100);
    final remaining =
        currency.format((targetCents - savedCents).clamp(0, targetCents) / 100);

    final panel = WireframePanel(
      backgroundColor: isActive ? backgroundColor : AppColors.creamSurface,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (emoji != null) ...[
                Text(emoji!, style: const TextStyle(fontSize: 36)),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: WireframeStyles.titleStyle(context),
                          ),
                        ),
                        if (isActive)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: WireframeStyles.boxDecoration(
                              color: AppColors.lemonYellow,
                            ),
                            child: Text(
                              'ACTIVE',
                              style: WireframeStyles.buttonLabelStyle(
                                context,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        if (_isComplete) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: WireframeStyles.boxDecoration(
                              color: AppColors.mintGreen,
                            ),
                            child: Text(
                              'DONE',
                              style: WireframeStyles.buttonLabelStyle(
                                context,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '$saved of $target',
                      style: WireframeStyles.labelStyle(context),
                    ),
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.close_rounded, color: AppColors.slate),
                  tooltip: 'Remove goal',
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          WireframeProgressBar(
            progress: _progress,
            label: 'Goal progress',
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: WireframeStatBox(
                  label: 'Saved',
                  value: saved,
                  backgroundColor: AppColors.mintGreen,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: WireframeStatBox(
                  label: 'To go',
                  value: remaining,
                  backgroundColor: AppColors.skyBlue,
                ),
              ),
            ],
          ),
          if (!isActive && onTap != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Tap to make this your active goal',
              style: WireframeStyles.pageSubtitleStyle(context),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) {
      return panel;
    }

    return LemonInteractive(onTap: onTap, child: panel);
  }
}
