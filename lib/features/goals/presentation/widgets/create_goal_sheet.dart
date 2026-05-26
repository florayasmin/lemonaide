import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/state/lemonaide_notifier.dart';
import '../../../../core/utils/money_input.dart';

/// Bottom sheet form for creating a new savings goal.
class CreateGoalSheet extends ConsumerStatefulWidget {
  const CreateGoalSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cream,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      builder: (context) => const Padding(
        padding: EdgeInsets.only(top: AppSpacing.md),
        child: CreateGoalSheet(),
      ),
    );
  }

  @override
  ConsumerState<CreateGoalSheet> createState() => _CreateGoalSheetState();
}

class _CreateGoalSheetState extends ConsumerState<CreateGoalSheet> {
  static const _emojiOptions = ['🚲', '🎮', '🎁', '📱', '🛼', '🎸', '⚽️', '🐶'];

  final _titleController = TextEditingController();
  final _targetController = TextEditingController();
  String? _selectedEmoji = '🚲';

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _submit() {
    final targetCents = parseDollarsToCents(_targetController.text);
    if (_titleController.text.trim().isEmpty) {
      _message('Give your goal a name');
      return;
    }
    if (targetCents == null) {
      _message('Enter a target amount greater than \$0');
      return;
    }

    ref.read(lemonaideProvider.notifier).createGoal(
          title: _titleController.text,
          targetCents: targetCents,
          emoji: _selectedEmoji,
        );

    Navigator.of(context).pop();
    _message('Goal created! Start saving toward it.');
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.slate.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'New savings goal',
            style: WireframeStyles.pageTitleStyle(context).copyWith(fontSize: 26),
          ),
          const SizedBox(height: AppSpacing.lg),
          WireframePanel(
            backgroundColor: AppColors.creamSurface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Goal name', style: WireframeStyles.labelStyle(context)),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  style: WireframeStyles.labelStyle(context),
                  decoration: InputDecoration(
                    hintText: 'New bike',
                    hintStyle: WireframeStyles.labelStyle(context).copyWith(
                      color: AppColors.slate.withValues(alpha: 0.4),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          WireframePanel(
            backgroundColor: AppColors.creamSurface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Target amount', style: WireframeStyles.labelStyle(context)),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: _targetController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: WireframeStyles.valueStyle(context).copyWith(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: r'$100.00',
                    hintStyle: WireframeStyles.labelStyle(context).copyWith(
                      color: AppColors.slate.withValues(alpha: 0.4),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Pick an icon', style: WireframeStyles.labelStyle(context)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final emoji in _emojiOptions)
                LemonInteractive(
                  onTap: () => setState(() => _selectedEmoji = emoji),
                  child: Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: WireframeStyles.boxDecoration(
                      color: _selectedEmoji == emoji
                          ? AppColors.lemonYellow
                          : AppColors.creamSurface,
                    ),
                    child: Text(emoji, style: const TextStyle(fontSize: 28)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          LemonButton(
            label: 'Create goal',
            icon: Icons.flag_rounded,
            size: LemonButtonSize.lg,
            variant: LemonButtonVariant.mint,
            expand: true,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
