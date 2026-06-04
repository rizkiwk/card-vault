import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Generic pie chart + legend for a `label → count` distribution
/// (used for rarity and condition breakdowns).
class DistributionPie extends StatelessWidget {
  const DistributionPie({super.key, required this.data});

  final Map<String, int> data;

  static const _palette = [
    Color(0xFF3D5AFE),
    Color(0xFF00BFA5),
    Color(0xFFFF6D00),
    Color(0xFFAA00FF),
    Color(0xFFFFD600),
    Color(0xFFEF5350),
    Color(0xFF26A69A),
    Color(0xFF8D6E63),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = data.values.fold<int>(0, (a, b) => a + b);
    if (total == 0) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text('No data yet',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),),
        ),
      );
    }

    final entries = data.entries.toList();
    return Row(
      children: [
        SizedBox(
          height: 160,
          width: 160,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 36,
              sections: [
                for (var i = 0; i < entries.length; i++)
                  PieChartSectionData(
                    value: entries[i].value.toDouble(),
                    color: _palette[i % _palette.length],
                    title: '${(entries[i].value / total * 100).round()}%',
                    radius: 44,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < entries.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _palette[i % _palette.length],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${entries[i].key} (${entries[i].value})',
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
