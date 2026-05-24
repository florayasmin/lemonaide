import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../domain/entities/dashboard_todo.dart';
import 'dashboard_panel_styles.dart';

/// TODO checklist with mascot placeholder — matches wireframe middle row.
class DashboardTodoBox extends StatelessWidget {
  const DashboardTodoBox({
    required this.todos,
    super.key,
  });

  final List<DashboardTodo> todos;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: DashboardPanelStyles.boxDecoration(color: AppColors.creamSurface),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TODO', style: DashboardPanelStyles.titleStyle(context)),
                const SizedBox(height: AppSpacing.sm),
                for (var i = 0; i < todos.length; i++) ...[
                  _TodoRow(todo: todos[i]),
                  if (i < todos.length - 1)
                    const SizedBox(height: AppSpacing.sm),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xxs),
          Transform.translate(
            offset: const Offset(-12, 0),
            child: const SizedBox(
              width: 108,
              height: 108,
              child: _MascotImage(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoRow extends StatelessWidget {
  const _TodoRow({required this.todo});

  final DashboardTodo todo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: todo.isDone ? AppColors.mintGreen : AppColors.creamSurface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.slate,
              width: DashboardPanelStyles.borderWidth,
            ),
          ),
          child: todo.isDone
              ? const Icon(Icons.check_rounded, size: 20, color: AppColors.slate)
              : null,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            todo.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: DashboardPanelStyles.labelStyle(context).copyWith(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: todo.isDone
                  ? AppColors.slate.withValues(alpha: 0.55)
                  : AppColors.slate,
            ),
          ),
        ),
      ],
    );
  }
}

class _MascotImage extends StatelessWidget {
  const _MascotImage();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.mascot,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.skyBlue,
            border: Border.all(
              color: AppColors.slate,
              width: DashboardPanelStyles.borderWidth,
            ),
          ),
          child: const Icon(
            Icons.pets_rounded,
            color: AppColors.slate,
            size: 36,
          ),
        );
      },
    );
  }
}
