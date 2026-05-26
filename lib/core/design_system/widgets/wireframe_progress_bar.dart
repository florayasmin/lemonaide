import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../tokens/wireframe_styles.dart';

/// Progress bar with thick slate outline — matches the home goal panel.
class WireframeProgressBar extends StatelessWidget {
  const WireframeProgressBar({
    required this.progress,
    this.label,
    this.showPercent = true,
    super.key,
  });

  final double progress;
  final String? label;
  final bool showPercent;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null || showPercent)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                if (label != null)
                  Expanded(
                    child: Text(label!, style: WireframeStyles.titleStyle(context)),
                  ),
                if (showPercent)
                  Text(
                    '${(clamped * 100).round()}%',
                    style: WireframeStyles.valueStyle(context).copyWith(fontSize: 22),
                  ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
          child: Container(
            height: 22,
            decoration: BoxDecoration(
              color: AppColors.creamSurface,
              borderRadius: AppSpacing.borderRadius(AppSpacing.radiusFull),
              border: Border.all(
                color: AppColors.slate,
                width: WireframeStyles.borderWidth,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      width: constraints.maxWidth * clamped,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius:
                            AppSpacing.borderRadius(AppSpacing.radiusFull),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
