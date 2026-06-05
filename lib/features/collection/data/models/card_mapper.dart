import 'package:drift/drift.dart';

import '../../../../core/constants/game_types.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/card.dart';

/// Maps between the drift row (`CardRow`) and the pure domain [CardEntity].
extension CardRowMapper on CardRow {
  CardEntity toEntity({
    GameType? game,
    String? setName,
    List<String> tags = const [],
    List<int> tagIds = const [],
    List<String> imagePaths = const [],
    String? thumbPath,
  }) {
    return CardEntity(
      id: id,
      game: game ?? GameType.pokemon,
      name: name,
      setId: setId,
      setName: setName,
      cardNumber: cardNumber,
      rarity: rarity,
      condition: CardCondition.fromCode(condition),
      quantity: quantity,
      status: CardStatus.fromCode(status),
      isFavorite: isFavorite,
      purchasePrice: purchasePrice,
      currentValue: currentValue,
      currency: currency,
      wishlistPriority: wishlistPriority,
      wishlistTargetPrice: wishlistTargetPrice,
      language: language,
      isGraded: isGraded,
      grade: grade,
      notes: notes,
      tags: tags,
      tagIds: tagIds,
      imagePaths: imagePaths,
      thumbPath: thumbPath,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }
}

/// Builds a drift insert/update companion from a domain entity.
/// [gameId] must be resolved from the entity's [GameType] before calling.
CardRowsCompanion cardCompanion(
  CardEntity card,
  int gameId, {
  bool forInsert = false,
}) {
  final now = DateTime.now().millisecondsSinceEpoch;
  return CardRowsCompanion(
    id: card.id == null ? const Value.absent() : Value(card.id!),
    gameId: Value(gameId),
    setId: Value(card.setId),
    name: Value(card.name.trim()),
    cardNumber: Value(card.cardNumber),
    rarity: Value(card.rarity),
    condition: Value(card.condition.code),
    quantity: Value(card.quantity),
    status: Value(card.status.code),
    isFavorite: Value(card.isFavorite),
    purchasePrice: Value(card.purchasePrice),
    currentValue: Value(card.currentValue),
    currency: Value(card.currency),
    wishlistPriority: Value(card.wishlistPriority),
    wishlistTargetPrice: Value(card.wishlistTargetPrice),
    language: Value(card.language),
    isGraded: Value(card.isGraded),
    grade: Value(card.grade),
    notes: Value(card.notes),
    createdAt: forInsert
        ? Value(card.createdAt?.millisecondsSinceEpoch ?? now)
        : const Value.absent(),
    updatedAt: Value(now),
  );
}
