import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../design_system/design_system.dart';
import '../spacing/app_spacing.dart';

/// Shared layout for MVP placeholder feature screens.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    required this.title,
    required this.subtitle,
    this.children = const [],
    super.key,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.screenPadding(context);

    return ColoredBox(
      color: AppColors.cream,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          padding,
          AppSpacing.md,
          padding,
          AppSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WireframePageHeader(title: title, subtitle: subtitle),
                SizedBox(height: AppSpacing.sectionGap(context)),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Quick "coming soon" card used on placeholder screens.
class ComingSoonCard extends StatelessWidget {
  const ComingSoonCard({
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return WireframePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            style: WireframeStyles.labelStyle(context),
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: AppSpacing.lg),
            LemonButton(
              label: actionLabel!,
              icon: Icons.add_rounded,
              size: LemonButtonSize.lg,
              expand: true,
              onPressed: onAction,
            ),
          ],
        ],
      ),
    );
  }
}
