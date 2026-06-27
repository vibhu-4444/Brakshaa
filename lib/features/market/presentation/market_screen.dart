import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/brakshaa_models.dart';
import '../../../repositories/brakshaa_repository.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/brakshaa_top_bar.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/status_chip.dart';

final financeControllerProvider =
    StateNotifierProvider<FinanceController, FinanceSummary>((ref) {
  return FinanceController(ref.watch(brakshaaRepositoryProvider).financeSummary());
});

class FinanceController extends StateNotifier<FinanceSummary> {
  FinanceController(super.state);

  void addFertilizerExpense() {
    state = FinanceSummary(
      netBalance: state.netBalance,
      income: state.income,
      expenses: state.expenses,
      monthly: state.monthly,
      transactions: [
        const FinanceTransaction(
          title: 'Soil Test Kit',
          time: 'Just now',
          amount: r'-$75.00',
          category: 'Supplies',
          positive: false,
        ),
        ...state.transactions,
      ],
    );
  }
}

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(financeControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: BrakshaaTopBar(title: l10n.t('app_name')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 126, 20, 136),
          children: [
            _BalanceHero(summary: summary),
            const SizedBox(height: 28),
            _SimpleMetricCard(label: l10n.t('income'), value: summary.income),
            const SizedBox(height: 20),
            _SimpleMetricCard(label: l10n.t('expenses'), value: summary.expenses),
            const SizedBox(height: 28),
            GlassCard(
              padding: const EdgeInsets.all(26),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.t('monthly_analytics'),
                          style: theme.textTheme.headlineMedium?.copyWith(fontSize: 23),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => showBrakshaaSnack(context, 'Year filter opened.'),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        label: Text(l10n.t('this_year')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _FinanceChart(months: summary.monthly),
                  const SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    children: const [
                      _LegendDot(label: 'Income', color: BrakshaaColors.primary),
                      _LegendDot(label: 'Expenses', color: Color(0xFFCBE7DC)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (final transaction in summary.transactions) ...[
                    _TransactionTile(transaction: transaction),
                    if (transaction != summary.transactions.last)
                      Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.25)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: 'Add Transaction',
              icon: Icons.add_rounded,
              onPressed: () {
                ref.read(financeControllerProvider.notifier).addFertilizerExpense();
                showBrakshaaSnack(context, 'Transaction saved locally and queued for sync.');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceHero extends StatelessWidget {
  const _BalanceHero({required this.summary});

  final FinanceSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined, color: theme.colorScheme.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                'NET BALANCE',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              summary.netBalance,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 52,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 12),
          StatusChip(
            label: '+12.5% vs last month',
            icon: Icons.trending_up_rounded,
          ),
        ],
      ),
    );
  }
}

class _SimpleMetricCard extends StatelessWidget {
  const _SimpleMetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: theme.textTheme.headlineLarge?.copyWith(fontSize: 34),
          ),
        ],
      ),
    );
  }
}

class _FinanceChart extends StatelessWidget {
  const _FinanceChart({required this.months});

  final List<MonthlyFinance> months;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 228,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < 4; i++)
                        Divider(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.34)),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (final month in months)
                      Expanded(
                        child: _MonthBar(month: month),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final month in months)
                Expanded(
                  child: Text(
                    month.month,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: month.month == 'MAY'
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: month.month == 'MAY' ? FontWeight.w900 : FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthBar extends StatelessWidget {
  const _MonthBar({required this.month});

  final MonthlyFinance month;

  @override
  Widget build(BuildContext context) {
    final isSelected = month.month == 'MAY';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        height: 164,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FractionallySizedBox(
              heightFactor: month.expenses,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 32,
                decoration: BoxDecoration(
                  color: isSelected ? BrakshaaColors.gold.withValues(alpha: 0.32) : const Color(0xFFCBE7DC),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
              ),
            ),
            FractionallySizedBox(
              heightFactor: month.income,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 32,
                decoration: BoxDecoration(
                  color: isSelected ? BrakshaaColors.gold : BrakshaaColors.primary,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final FinanceTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = transaction.positive ? theme.colorScheme.primary : theme.colorScheme.error;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: transaction.positive
            ? BrakshaaColors.gold.withValues(alpha: 0.12)
            : theme.colorScheme.surfaceContainerHighest,
        foregroundColor: transaction.positive ? BrakshaaColors.tertiary : theme.colorScheme.onSurfaceVariant,
        child: Icon(transaction.positive ? Icons.storefront_outlined : Icons.water_drop_outlined),
      ),
      title: Text(transaction.title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 18)),
      subtitle: Text(transaction.time),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            transaction.amount,
            style: theme.textTheme.titleLarge?.copyWith(color: color),
          ),
          const SizedBox(height: 6),
          StatusChip(label: transaction.category, compact: true, color: transaction.positive ? theme.colorScheme.primary : theme.colorScheme.outline),
        ],
      ),
    );
  }
}
