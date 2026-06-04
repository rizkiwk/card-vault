import '../../../../core/constants/game_types.dart';

enum CardSort { dateAddedDesc, nameAsc, valueDesc, quantityDesc }

/// Immutable description of the current Collection/Wishlist query.
class CardFilter {
  const CardFilter({
    this.status = CardStatus.owned,
    this.game,
    this.setId,
    this.rarity,
    this.condition,
    this.tagIds = const [],
    this.favoritesOnly = false,
    this.minValue,
    this.maxValue,
    this.search = '',
    this.sort = CardSort.dateAddedDesc,
  });

  final CardStatus status;
  final GameType? game;
  final int? setId;
  final String? rarity;
  final CardCondition? condition;
  final List<int> tagIds;
  final bool favoritesOnly;
  final double? minValue;
  final double? maxValue;
  final String search;
  final CardSort sort;

  CardFilter copyWith({
    CardStatus? status,
    GameType? game,
    bool clearGame = false,
    int? setId,
    bool clearSet = false,
    String? rarity,
    CardCondition? condition,
    bool clearCondition = false,
    List<int>? tagIds,
    bool? favoritesOnly,
    double? minValue,
    double? maxValue,
    String? search,
    CardSort? sort,
  }) {
    return CardFilter(
      status: status ?? this.status,
      game: clearGame ? null : (game ?? this.game),
      setId: clearSet ? null : (setId ?? this.setId),
      rarity: rarity ?? this.rarity,
      condition: clearCondition ? null : (condition ?? this.condition),
      tagIds: tagIds ?? this.tagIds,
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      search: search ?? this.search,
      sort: sort ?? this.sort,
    );
  }
}
