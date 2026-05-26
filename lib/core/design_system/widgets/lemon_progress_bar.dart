import 'package:flutter/material.dart';

import '../../spacing/app_spacing.dart';
import '../tokens/wireframe_styles.dart';
import 'wireframe_progress_bar.dart';

class LemonProgressBar extends StatelessWidget {
  const LemonProgressBar({
    required this.value,
    this.label,
    this.subtitle,
    this.height = AppSpacing.progressHeight,
    this.showPercent = false,
    super.key,
  });

  final double value;
  final String? label;
  final String? subtitle;
  final double height;
  final bool showPercent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WireframeProgressBar(
          progress: value,
          label: label,
          showPercent: showPercent,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(subtitle!, style: WireframeStyles.labelStyle(context)),
        ],
      ],
    );
  }
}
