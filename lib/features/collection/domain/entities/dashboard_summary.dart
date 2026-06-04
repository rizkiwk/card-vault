import '../../../../core/constants/game_types.dart';

/// Aggregated figures for the Dashboard screen.
class DashboardSummary {
  const DashboardSummary({
    required this.totalValue,
    required this.totalSpent,
    required this.totalCopies,
    required this.uniqueCards,
    required this.perGame,
  });

  final double totalValue;
  final double totalSpent;
  final int totalCopies;
  final int uniqueCards;
  final Map<GameType, int> perGame;

  double get gainLoss => totalValue - totalSpent;

  double? get gainLossPercent {
    if (totalSpent <= 0) return null;
    return (gainLoss / totalSpent) * 100;
  }

  static const empty = DashboardSummary(
    totalValue: 0,
    totalSpent: 0,
    totalCopies: 0,
    uniqueCards: 0,
    perGame: {},
  );
}
