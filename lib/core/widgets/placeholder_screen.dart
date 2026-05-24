import 'package:flutter/material.dart';

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

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        padding,
        padding,
        padding,
        AppSpacing.xxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(title: title, subtitle: subtitle),
              SizedBox(height: AppSpacing.sectionGap(context)),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
        ),
      ],
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
    return LemonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
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
