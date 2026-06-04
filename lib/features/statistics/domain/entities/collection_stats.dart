import '../../../../core/constants/game_types.dart';

/// A single most-valuable card row for the Top-N list.
class ValuableCard {
  const ValuableCard({required this.name, required this.value, this.id});
  final int? id;
  final String name;
  final double value;
}

/// Aggregated analytics for the Statistics screen. Computed entirely from the
/// local DB (owned cards only).
class CollectionStats {
  const CollectionStats({
    required this.totalValue,
    required this.totalSpent,
    required this.totalCopies,
    required this.uniqueCards,
    required this.setsCount,
    required this.valueByGame,
    required this.countByRarity,
    required this.countByCondition,
    required this.topValuable,
  });

  final double totalValue;
  final double totalSpent;
  final int totalCopies;
  final int uniqueCards;
  final int setsCount;

  final Map<GameType, double> valueByGame;
  final Map<String, int> countByRarity;
  final Map<CardCondition, int> countByCondition;
  final List<ValuableCard> topValuable;

  /// Absolute gain/loss (current − spent). Only meaningful where both
  /// prices were entered.
  double get gainLoss => totalValue - totalSpent;

  /// Gain/loss as a percentage of money spent. Null when nothing was spent.
  double? get gainLossPercent {
    if (totalSpent <= 0) return null;
    return (gainLoss / totalSpent) * 100;
  }

  static const empty = CollectionStats(
    totalValue: 0,
    totalSpent: 0,
    totalCopies: 0,
    uniqueCards: 0,
    setsCount: 0,
    valueByGame: {},
    countByRarity: {},
    countByCondition: {},
    topValuable: [],
  );
}
