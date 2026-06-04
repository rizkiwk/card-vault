import '../../../../core/constants/game_types.dart';

/// Pure domain entity. No Flutter, drift, or Riverpod imports allowed here.
class CardEntity {
  const CardEntity({
    this.id,
    required this.game,
    required this.name,
    this.setId,
    this.setName,
    this.cardNumber,
    this.rarity,
    this.condition = CardCondition.nearMint,
    this.quantity = 1,
    this.status = CardStatus.owned,
    this.isFavorite = false,
    this.purchasePrice,
    this.currentValue,
    this.currency = 'USD',
    this.wishlistPriority,
    this.wishlistTargetPrice,
    this.language,
    this.isGraded = false,
    this.grade,
    this.notes,
    this.tags = const [],
    this.tagIds = const [],
    this.imagePaths = const [],
    this.thumbPath,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final GameType game;
  final String name;
  final int? setId;
  final String? setName;
  final String? cardNumber;
  final String? rarity;
  final CardCondition condition;
  final int quantity;
  final CardStatus status;
  final bool isFavorite;
  final double? purchasePrice;
  final double? currentValue;
  final String currency;
  final int? wishlistPriority;
  final double? wishlistTargetPrice;
  final String? language;
  final bool isGraded;
  final String? grade;
  final String? notes;

  /// Tag display names (read path).
  final List<String> tags;

  /// Tag ids (write path — used to sync the `card_tags` junction).
  final List<int> tagIds;
  final List<String> imagePaths;
  final String? thumbPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Total value of all copies of this card.
  double get totalValue => (currentValue ?? 0) * quantity;

  /// Gain/loss vs purchase price (null if either price missing).
  double? get gainLoss {
    if (currentValue == null || purchasePrice == null) return null;
    return (currentValue! - purchasePrice!) * quantity;
  }

  CardEntity copyWith({
    int? id,
    GameType? game,
    String? name,
    int? setId,
    String? setName,
    String? cardNumber,
    String? rarity,
    CardCondition? condition,
    int? quantity,
    CardStatus? status,
    bool? isFavorite,
    double? purchasePrice,
    double? currentValue,
    String? currency,
    int? wishlistPriority,
    double? wishlistTargetPrice,
    String? language,
    bool? isGraded,
    String? grade,
    String? notes,
    List<String>? tags,
    List<int>? tagIds,
    List<String>? imagePaths,
    String? thumbPath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CardEntity(
      id: id ?? this.id,
      game: game ?? this.game,
      name: name ?? this.name,
      setId: setId ?? this.setId,
      setName: setName ?? this.setName,
      cardNumber: cardNumber ?? this.cardNumber,
      rarity: rarity ?? this.rarity,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      currentValue: currentValue ?? this.currentValue,
      currency: currency ?? this.currency,
      wishlistPriority: wishlistPriority ?? this.wishlistPriority,
      wishlistTargetPrice: wishlistTargetPrice ?? this.wishlistTargetPrice,
      language: language ?? this.language,
      isGraded: isGraded ?? this.isGraded,
      grade: grade ?? this.grade,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      tagIds: tagIds ?? this.tagIds,
      imagePaths: imagePaths ?? this.imagePaths,
      thumbPath: thumbPath ?? this.thumbPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
