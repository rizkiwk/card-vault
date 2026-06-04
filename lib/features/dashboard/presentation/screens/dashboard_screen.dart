import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/game_types.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../collection/presentation/providers/card_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CardVault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.insights_outlined),
            tooltip: 'Statistics',
            onPressed: () => context.go('/statistics'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: summary.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (s) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Collection Value',
                        style: theme.textTheme.labelLarge,),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          CurrencyFormatter.format(s.totalValue),
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        if (s.totalSpent > 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              '${s.gainLoss >= 0 ? '▲' : '▼'} '
                              '${s.gainLossPercent!.toStringAsFixed(1)}%',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: s.gainLoss >= 0
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${s.totalCopies} cards · ${s.uniqueCards} unique',
                        style: theme.textTheme.bodyMedium,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('By Game', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: GameType.values.map((g) {
                return Card(
                  child: Center(
                    child: ListTile(
                      title: Text(g.label,
                          maxLines: 1, overflow: TextOverflow.ellipsis,),
                      trailing: Text('${s.perGame[g] ?? 0}',
                          style: theme.textTheme.titleLarge,),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/add'),
        icon: const Icon(Icons.add),
        label: const Text('Add Card'),
      ),
    );
  }
}
