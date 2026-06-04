import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/game_types.dart';
import '../../../../core/services/image_storage_service.dart';
import '../../../../shared/providers/database_provider.dart';
import '../../data/datasources/card_local_datasource.dart';
import '../../data/repositories/card_repository_impl.dart';
import '../../domain/entities/card.dart';
import '../../domain/entities/card_filter.dart';
import '../../domain/entities/dashboard_summary.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/usecases/card_usecases.dart';

// ---- Infrastructure ----

final imageStorageServiceProvider =
    Provider<ImageStorageService>((ref) => ImageStorageService());

final cardLocalDataSourceProvider = Provider<CardLocalDataSource>((ref) {
  return CardLocalDataSource(ref.watch(appDatabaseProvider));
});

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  return CardRepositoryImpl(ref.watch(cardLocalDataSourceProvider));
});

// ---- Use cases ----

final addCardProvider =
    Provider((ref) => AddCard(ref.watch(cardRepositoryProvider)));
final updateCardProvider =
    Provider((ref) => UpdateCard(ref.watch(cardRepositoryProvider)));
final deleteCardProvider =
    Provider((ref) => DeleteCard(ref.watch(cardRepositoryProvider)));
final toggleFavoriteProvider =
    Provider((ref) => ToggleFavorite(ref.watch(cardRepositoryProvider)));
final markAsOwnedProvider =
    Provider((ref) => MarkAsOwned(ref.watch(cardRepositoryProvider)));
final getCardByIdProvider =
    Provider((ref) => GetCardById(ref.watch(cardRepositoryProvider)));

// ---- Filter state (Collection) ----

class CardFilterNotifier extends Notifier<CardFilter> {
  @override
  CardFilter build() => const CardFilter();

  void setSearch(String value) => state = state.copyWith(search: value);
  void setSort(CardSort sort) => state = state.copyWith(sort: sort);
  void toggleFavoritesOnly() =>
      state = state.copyWith(favoritesOnly: !state.favoritesOnly);
  void setGame(GameType? game) => state = game == null
      ? state.copyWith(clearGame: true)
      : state.copyWith(game: game);
  void setCondition(CardCondition? condition) => condition == null
      ? state = state.copyWith(clearCondition: true)
      : state = state.copyWith(condition: condition);
  void setSetId(int? setId) => setId == null
      ? state = state.copyWith(clearSet: true)
      : state = state.copyWith(setId: setId);
  void setRarity(String? rarity) =>
      state = state.copyWith(rarity: rarity ?? '');
  void setTagIds(List<int> tagIds) => state = state.copyWith(tagIds: tagIds);
  void toggleTag(int tagId) {
    final next = [...state.tagIds];
    next.contains(tagId) ? next.remove(tagId) : next.add(tagId);
    state = state.copyWith(tagIds: next);
  }

  void setValueRange(double? min, double? max) =>
      state = state.copyWith(minValue: min, maxValue: max);
  void reset() => state = CardFilter(status: state.status);
}

final cardFilterProvider =
    NotifierProvider<CardFilterNotifier, CardFilter>(CardFilterNotifier.new);

// ---- Available sets (for the filter sheet & add-card set picker) ----

class SetOption {
  const SetOption(this.id, this.name);
  final int id;
  final String name;
}

final setsProvider = FutureProvider<List<SetOption>>((ref) async {
  // Recompute when the collection changes (new sets may appear).
  ref.watch(cardListProvider);
  final rows = await ref.watch(cardLocalDataSourceProvider).allSets();
  return rows.map((s) => SetOption(s.id, s.name)).toList();
});

// ---- Reactive card list (Collection) ----

final cardListProvider = StreamProvider.autoDispose<List<CardEntity>>((ref) {
  final filter = ref.watch(cardFilterProvider);
  return ref.watch(cardRepositoryProvider).watchCards(filter);
});

// ---- Single card (Detail) ----

final cardDetailProvider =
    FutureProvider.autoDispose.family<CardEntity, int>((ref, id) async {
  final result = await ref.watch(getCardByIdProvider).call(id);
  return result.fold((f) => throw Exception(f.message), (card) => card);
});

// ---- Dashboard summary ----

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) {
  // Recompute whenever the collection changes.
  ref.watch(cardListProvider);
  return ref.watch(cardRepositoryProvider).getSummary();
});
