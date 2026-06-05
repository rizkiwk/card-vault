import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/game_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/gradient_widgets.dart';
import '../../../../core/widgets/vault_logo.dart';
import '../../../collection/presentation/providers/card_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const VaultLockup(),
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
            _ValueHero(
              totalValue: s.totalValue,
              gainLoss: s.gainLoss,
              gainLossPercent: s.totalSpent > 0 ? s.gainLossPercent : null,
              totalCopies: s.totalCopies,
              uniqueCards: s.uniqueCards,
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
                      title: Text(
                        g.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        '${s.perGame[g] ?? 0}',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: GradientFab(
        onPressed: () => context.go('/add'),
        tooltip: 'Add Card',
      ),
    );
  }
}

/// Gradient hero showing total collection value and gain/loss.
class _ValueHero extends StatelessWidget {
  const _ValueHero({
    required this.totalValue,
    required this.gainLoss,
    required this.gainLossPercent,
    required this.totalCopies,
    required this.uniqueCards,
  });

  final double totalValue;
  final double gainLoss;
  final double? gainLossPercent;
  final int totalCopies;
  final int uniqueCards;

  @override
  Widget build(BuildContext context) {
    final positive = gainLoss >= 0;
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
          Text(
            'Total Collection Value',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    CurrencyFormatter.format(totalValue),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 32,
                      height: 36 / 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
              if (gainLossPercent != null) ...[
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
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
                          size: 13,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${gainLossPercent!.abs().toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '$totalCopies cards · $uniqueCards unique',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
