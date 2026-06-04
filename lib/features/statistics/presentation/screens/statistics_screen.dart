import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/collection_stats.dart';
import '../providers/statistics_provider.dart';
import '../widgets/distribution_pie.dart';
import '../widgets/value_bar_chart.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: stats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (s) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _OverviewCard(stats: s),
            const SizedBox(height: 24),
            _Section(
              title: 'Value by Game',
              child: ValueBarChart(valueByGame: s.valueByGame),
            ),
            const SizedBox(height: 24),
            _Section(
              title: 'By Rarity',
              child: DistributionPie(data: s.countByRarity),
            ),
            const SizedBox(height: 24),
            _Section(
              title: 'By Condition',
              child: DistributionPie(data: {
                for (final e in s.countByCondition.entries) e.key.code: e.value,
              },),
            ),
            const SizedBox(height: 24),
            _Section(
              title: 'Top 5 Most Valuable',
              child: _TopValuable(cards: s.topValuable),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.stats});
  final CollectionStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gl = stats.gainLoss;
    final pct = stats.gainLossPercent;
    final positive = gl >= 0;

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Value', style: theme.textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(
              CurrencyFormatter.format(stats.totalValue),
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _Metric(label: 'Spent', value: CurrencyFormatter.format(stats.totalSpent)),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gain / Loss', style: theme.textTheme.labelMedium),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          positive ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 16,
                          color: positive ? Colors.green.shade700 : Colors.red.shade700,
                        ),
                        Text(
                          '${CurrencyFormatter.formatSigned(gl)}'
                          '${pct != null ? ' (${pct.toStringAsFixed(1)}%)' : ''}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: positive
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              '${stats.totalCopies} cards · ${stats.uniqueCards} unique · ${stats.setsCount} sets',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium),
        const SizedBox(height: 2),
        Text(value, style: theme.textTheme.titleMedium),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _TopValuable extends StatelessWidget {
  const _TopValuable({required this.cards});
  final List<ValuableCard> cards;
  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Text('No priced cards yet',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.outline),);
    }
    return Column(
      children: [
        for (var i = 0; i < cards.length; i++)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(radius: 14, child: Text('${i + 1}')),
            title: Text(cards[i].name, overflow: TextOverflow.ellipsis),
            trailing: Text(
              CurrencyFormatter.format(cards[i].value),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
      ],
    );
  }
}
