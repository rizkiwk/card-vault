import '../../../../core/utils/result.dart';
import '../../../statistics/domain/entities/collection_stats.dart';
import '../entities/card.dart';
import '../entities/card_filter.dart';
import '../entities/dashboard_summary.dart';

/// Domain-facing contract. Implemented in the data layer.
abstract interface class CardRepository {
  /// Reactive stream of cards matching [filter]; emits on any DB change.
  Stream<List<CardEntity>> watchCards(CardFilter filter);

  Future<Result<CardEntity>> getById(int id);

  /// Returns the new card id on success.
  Future<Result<int>> add(CardEntity card);

  Future<Result<void>> update(CardEntity card);

  Future<Result<void>> delete(int id);

  Future<Result<void>> toggleFavorite(int id);

  /// Promote a wishlist card to owned.
  Future<Result<void>> markAsOwned(int id);

  Future<DashboardSummary> getSummary();

  /// Full analytics breakdown for the Statistics screen (owned cards only).
  Future<CollectionStats> getStatistics();
}
