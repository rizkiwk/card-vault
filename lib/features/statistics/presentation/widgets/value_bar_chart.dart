import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/game_types.dart';

/// Horizontal-feel vertical bar chart of collection value per game.
class ValueBarChart extends StatelessWidget {
  const ValueBarChart({super.key, required this.valueByGame});

  final Map<GameType, double> valueByGame;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const games = GameType.values;
    final maxVal = valueByGame.values.isEmpty
        ? 1.0
        : valueByGame.values.reduce((a, b) => a > b ? a : b);

    if (valueByGame.values.every((v) => v == 0)) {
      return const _ChartEmpty();
    }

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: maxVal * 1.2,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= games.length) {
                    return const SizedBox.shrink();
                  }
                  // Short code, e.g. "PKM".
                  final label = games[i].code.substring(0, 3).toUpperCase();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(label, style: theme.textTheme.labelSmall),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < games.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: valueByGame[games[i]] ?? 0,
                    width: 22,
                    borderRadius: BorderRadius.circular(6),
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ChartEmpty extends StatelessWidget {
  const _ChartEmpty();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Text(
          'No value data yet',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
      ),
    );
  }
}
