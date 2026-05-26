import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../spacing/app_spacing.dart';
import '../tokens/wireframe_styles.dart';

/// Thick-outline panel used across feature screens.
class WireframePanel extends StatelessWidget {
  const WireframePanel({
    required this.child,
    this.backgroundColor,
    this.padding,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
      decoration: WireframeStyles.boxDecoration(color: backgroundColor),
      child: child,
    );
  }
}

/// Page title + subtitle matching the home wireframe look.
class WireframePageHeader extends StatelessWidget {
  const WireframePageHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: WireframeStyles.pageTitleStyle(context)),
        const SizedBox(height: AppSpacing.xs),
        Text(subtitle, style: WireframeStyles.pageSubtitleStyle(context)),
      ],
    );
  }
}

/// Stat box — label + big value (matches home dashboard stat boxes).
class WireframeStatBox extends StatelessWidget {
  const WireframeStatBox({
    required this.label,
    required this.value,
    this.backgroundColor = AppColors.creamSurface,
    super.key,
  });

  final String label;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return WireframePanel(
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: WireframeStyles.labelStyle(context)),
          const SizedBox(height: AppSpacing.xxs),
          Text(value, style: WireframeStyles.valueStyle(context)),
        ],
      ),
    );
  }
}
