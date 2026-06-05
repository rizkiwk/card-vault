import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
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
              child: DistributionPie(
                data: {
                  for (final e in s.countByCondition.entries)
                    e.key.code: e.value,
                },
              ),
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

    final white70 = Colors.white.withValues(alpha: 0.85);
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.indigo.withValues(alpha: 0.40),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Value',
              style: theme.textTheme.labelMedium?.copyWith(color: white70),),
          const SizedBox(height: 4),
          Text(
            CurrencyFormatter.format(stats.totalValue),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'PlusJakartaSans',
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _HeroMetric(
                label: 'Spent',
                value: CurrencyFormatter.formatCompact(stats.totalSpent),
              ),
              const SizedBox(width: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gain / Loss',
                      style: theme.textTheme.labelMedium
                          ?.copyWith(color: white70),),
                  const SizedBox(height: 3),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          positive
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${CurrencyFormatter.formatSigned(gl)}'
                          '${pct != null ? ' (${pct.toStringAsFixed(1)}%)' : ''}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 28, color: Colors.white.withValues(alpha: 0.20)),
          Text(
            '${stats.totalCopies} cards · ${stats.uniqueCards} unique · ${stats.setsCount} sets',
            style: theme.textTheme.bodyMedium?.copyWith(color: white70),
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final white70 = Colors.white.withValues(alpha: 0.85);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: white70),),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'PlusJakartaSans',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
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
      return Text(
        'No priced cards yet',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.outline),
      );
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
