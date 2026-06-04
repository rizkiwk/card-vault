import 'package:drift/drift.dart';

import '../../../../core/constants/game_types.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/image_storage_service.dart';
import '../../../../core/utils/result.dart';
import '../../../statistics/domain/entities/collection_stats.dart';
import '../../domain/entities/card.dart';
import '../../domain/entities/card_filter.dart';
import '../../domain/entities/dashboard_summary.dart';
import '../../domain/repositories/card_repository.dart';
import '../datasources/card_local_datasource.dart';
import '../models/card_mapper.dart';

/// Concrete repository: bridges domain ↔ drift. Catches all exceptions and
/// returns [Result], so the domain/presentation layers never see raw errors.
class CardRepositoryImpl implements CardRepository {
  CardRepositoryImpl(this._ds);
  final CardLocalDataSource _ds;

  @override
  Stream<List<CardEntity>> watchCards(CardFilter filter) {
    // Game & tag filtering happen in SQL (see CardLocalDataSource.watchCards);
    // here we only hydrate each row with its related data for display.
    return _ds.watchCards(filter).asyncMap((rows) async {
      final result = <CardEntity>[];
      for (final row in rows) {
        final images = await _ds.imagesForCard(row.id);
        final primary = images.isNotEmpty
            ? (images.firstWhere((i) => i.isPrimary, orElse: () => images.first))
            : null;

        result.add(row.toEntity(
          game: GameType.fromCode(await _ds.gameCodeForId(row.gameId)),
          setName: await _ds.setNameForId(row.setId),
          tags: await _ds.tagNamesForCard(row.id),
          tagIds: await _ds.tagIdsForCard(row.id),
          imagePaths: images.map((i) => i.filePath).toList(),
          thumbPath: primary?.thumbPath ?? primary?.filePath,
        ),);
      }
      return result;
    });
  }

  @override
  Future<Result<CardEntity>> getById(int id) async {
    try {
      final row = await _ds.getById(id);
      if (row == null) return const Err(NotFoundFailure());
      final images = await _ds.imagesForCard(id);
      final primary = images.isNotEmpty
          ? images.firstWhere((i) => i.isPrimary, orElse: () => images.first)
          : null;
      final entity = row.toEntity(
        game: GameType.fromCode(await _ds.gameCodeForId(row.gameId)),
        setName: await _ds.setNameForId(row.setId),
        tags: await _ds.tagNamesForCard(id),
        tagIds: await _ds.tagIdsForCard(id),
        imagePaths: images.map((i) => i.filePath).toList(),
        thumbPath: primary?.thumbPath ?? primary?.filePath,
      );
      return Success(entity);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<int>> add(CardEntity card) async {
    try {
      final gameId = await _ds.gameIdForCode(card.game.code);
      final id = await _ds.insert(cardCompanion(card, gameId, forInsert: true));

      // Persist any captured image paths supplied by the controller.
      for (var i = 0; i < card.imagePaths.length; i++) {
        final filePath = card.imagePaths[i];
        await _ds.addImage(CardImagesCompanion.insert(
          cardId: id,
          filePath: filePath,
          thumbPath: Value(ImageStorageService.thumbPathFor(filePath)),
          isPrimary: Value(i == 0),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),);
      }
      await _ds.setCardTags(id, card.tagIds);
      return Success(id);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> update(CardEntity card) async {
    try {
      final gameId = await _ds.gameIdForCode(card.game.code);
      await _ds.updateCard(cardCompanion(card, gameId));
      if (card.id != null) {
        await _ds.setCardTags(card.id!, card.tagIds);
      }
      return const Success(null);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try {
      // card_images rows cascade-delete via FK; orphan files are cleaned by
      // the ImageStorageService in the controller before this call.
      await _ds.deleteCard(id);
      return const Success(null);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> toggleFavorite(int id) async {
    try {
      final row = await _ds.getById(id);
      if (row == null) return const Err(NotFoundFailure());
      await _ds.setFavorite(id, !row.isFavorite);
      return const Success(null);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> markAsOwned(int id) async {
    try {
      await _ds.setStatus(id, CardStatus.owned.code);
      return const Success(null);
    } catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<DashboardSummary> getSummary() async {
    try {
      final totalValue = await _ds.totalOwnedValue();
      final totalSpent = await _ds.totalOwnedSpent();
      final totals = await _ds.totals();
      final perGameRaw = await _ds.countsPerGame();
      final perGame = <GameType, int>{
        for (final g in perGameRaw) GameType.fromCode(g.gameCode): g.count,
      };
      return DashboardSummary(
        totalValue: totalValue,
        totalSpent: totalSpent,
        totalCopies: totals.copies,
        uniqueCards: totals.unique,
        perGame: perGame,
      );
    } catch (_) {
      return DashboardSummary.empty;
    }
  }

  @override
  Future<CollectionStats> getStatistics() async {
    try {
      final totalValue = await _ds.totalOwnedValue();
      final totalSpent = await _ds.totalOwnedSpent();
      final totals = await _ds.totals();
      final setsCount = await _ds.distinctSetsCount();

      final valueByGame = <GameType, double>{
        for (final g in await _ds.valueByGame())
          GameType.fromCode(g.gameCode): g.value,
      };
      final countByRarity = await _ds.countByRarity();
      final countByConditionRaw = await _ds.countByCondition();
      final countByCondition = <CardCondition, int>{
        for (final e in countByConditionRaw.entries)
          CardCondition.fromCode(e.key): e.value,
      };
      final topValuable = (await _ds.topValuable(5))
          .map((c) => ValuableCard(id: c.id, name: c.name, value: c.value))
          .toList();

      return CollectionStats(
        totalValue: totalValue,
        totalSpent: totalSpent,
        totalCopies: totals.copies,
        uniqueCards: totals.unique,
        setsCount: setsCount,
        valueByGame: valueByGame,
        countByRarity: countByRarity,
        countByCondition: countByCondition,
        topValuable: topValuable,
      );
    } catch (_) {
      return CollectionStats.empty;
    }
  }
}
