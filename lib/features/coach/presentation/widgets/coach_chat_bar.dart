import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/design_system/tokens/wireframe_styles.dart';
import '../../../../core/spacing/app_spacing.dart';

class CoachChatBar extends StatelessWidget {
  const CoachChatBar({
    required this.controller,
    this.onSend,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: WireframeStyles.boxDecoration(color: AppColors.creamSurface),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 2,
              minLines: 1,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend?.call(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.slate,
                    fontWeight: FontWeight.w600,
                  ),
              decoration: InputDecoration(
                hintText: 'Ask Leo anything...',
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.slate.withValues(alpha: 0.45),
                    ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onSend,
            icon: const Icon(
              Icons.send_rounded,
              color: AppColors.slate,
              size: 28,
            ),
            tooltip: 'Send message',
          ),
        ],
      ),
    );
  }
}
