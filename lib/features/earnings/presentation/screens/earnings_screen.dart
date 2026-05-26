import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/design_system/design_system.dart';
import '../../../../core/spacing/app_spacing.dart';
import '../../../../core/state/earnings_input_provider.dart';
import '../../../../core/state/lemonaide_notifier.dart';
import '../../../../core/utils/money_input.dart';
import '../../domain/entities/earning.dart';

class EarningsScreen extends ConsumerStatefulWidget {
  const EarningsScreen({super.key});

  @override
  ConsumerState<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends ConsumerState<EarningsScreen> {
  static const _sourceOptions = [
    (
      EarningSource.lemonadeStand,
      'Lemonade stand',
      Icons.local_drink_rounded,
      AppColors.lemonYellow,
    ),
    (
      EarningSource.chores,
      'Chores',
      Icons.cleaning_services_rounded,
      AppColors.mintGreen,
    ),
    (
      EarningSource.allowance,
      'Allowance',
      Icons.account_balance_wallet_rounded,
      AppColors.skyBlue,
    ),
    (
      EarningSource.babysitting,
      'Babysitting',
      Icons.child_care_rounded,
      AppColors.blue,
    ),
    (
      EarningSource.dogWalking,
      'Dog walking',
      Icons.pets_rounded,
      AppColors.pastelYellow,
    ),
  ];

  final _amountController = TextEditingController();
  EarningSource? _selectedSource;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pending = ref.read(pendingEarningSourceProvider);
      if (pending != null && mounted) {
        setState(() => _selectedSource = pending);
        ref.read(pendingEarningSourceProvider.notifier).state = null;
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    final cents = parseDollarsToCents(_amountController.text);
    if (cents == null) {
      _showMessage('Enter a valid amount greater than \$0');
      return;
    }
    if (_selectedSource == null) {
      _showMessage('Pick where the money came from');
      return;
    }

    ref.read(lemonaideProvider.notifier).addEarning(
          amountCents: cents,
          source: _selectedSource!,
        );

    _amountController.clear();
    setState(() => _selectedSource = null);

    final formatted = NumberFormat.currency(symbol: r'$').format(cents / 100);
    _showMessage('Added $formatted! 🍋');
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.screenPadding(context);
    final earnings = ref.watch(lemonaideProvider).earnings;
    final currency = NumberFormat.currency(symbol: r'$');
    final sorted = List<Earning>.from(earnings)
      ..sort((a, b) => b.earnedAt.compareTo(a.earnedAt));

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
                const WireframePageHeader(
                  title: AppStrings.earningsTitle,
                  subtitle: AppStrings.earningsSubtitle,
                ),
                SizedBox(height: AppSpacing.sectionGap(context)),
                Text(
                  'Where did it come from?',
                  style: WireframeStyles.labelStyle(context),
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final (source, label, icon, color) in _sourceOptions)
                      LemonWireframeChip(
                        label: label,
                        icon: icon,
                        backgroundColor: color,
                        isSelected: _selectedSource == source,
                        onPressed: () => setState(() => _selectedSource = source),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                WireframePanel(
                  backgroundColor: AppColors.creamSurface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Amount earned',
                        style: WireframeStyles.labelStyle(context),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: WireframeStyles.valueStyle(context).copyWith(
                          fontSize: 24,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _submit(),
                        decoration: InputDecoration(
                          hintText: r'$0.00',
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
                const SizedBox(height: AppSpacing.lg),
                LemonButton(
                  label: 'Add earning',
                  icon: Icons.add_rounded,
                  size: LemonButtonSize.lg,
                  expand: true,
                  onPressed: _submit,
                ),
                if (sorted.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Recent log',
                    style: WireframeStyles.titleStyle(context),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  for (final earning in sorted.take(6))
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: WireframePanel(
                        backgroundColor: AppColors.creamSurface,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    earning.source.displayName,
                                    style: WireframeStyles.labelStyle(context),
                                  ),
                                  Text(
                                    DateFormat.MMMd().add_jm().format(
                                          earning.earnedAt,
                                        ),
                                    style: WireframeStyles.pageSubtitleStyle(
                                      context,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              currency.format(earning.amountCents / 100),
                              style: WireframeStyles.valueStyle(context).copyWith(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
