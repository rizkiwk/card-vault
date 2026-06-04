import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/card_filter.dart';

/// Thin wrapper over drift queries for the cards feature.
class CardLocalDataSource {
  CardLocalDataSource(this._db);
  final AppDatabase _db;

  /// Reactive, filtered, sorted stream of card rows.
  Stream<List<CardRow>> watchCards(CardFilter f) {
    final query = _db.select(_db.cardRows)
      ..where((t) => t.status.equals(f.status.code));

    if (f.favoritesOnly) {
      query.where((t) => t.isFavorite.equals(true));
    }
    if (f.setId != null) {
      query.where((t) => t.setId.equals(f.setId!));
    }
    if (f.condition != null) {
      query.where((t) => t.condition.equals(f.condition!.code));
    }
    if (f.rarity != null && f.rarity!.isNotEmpty) {
      query.where((t) => t.rarity.equals(f.rarity!));
    }
    if (f.minValue != null) {
      query.where((t) => t.currentValue.isBiggerOrEqualValue(f.minValue!));
    }
    if (f.maxValue != null) {
      query.where((t) => t.currentValue.isSmallerOrEqualValue(f.maxValue!));
    }
    if (f.search.trim().isNotEmpty) {
      final term = '%${f.search.trim()}%';
      query.where((t) =>
          t.name.like(term) | t.cardNumber.like(term) | t.notes.like(term),);
    }
    if (f.game != null) {
      // Subquery: card.gameId IN (SELECT id FROM games WHERE code = ?)
      final gameIds = _db.selectOnly(_db.games)
        ..addColumns([_db.games.id])
        ..where(_db.games.code.equals(f.game!.code));
      query.where((t) => t.gameId.isInQuery(gameIds));
    }
    if (f.tagIds.isNotEmpty) {
      // Subquery: card.id IN (SELECT cardId FROM card_tags WHERE tagId IN (...))
      final taggedCardIds = _db.selectOnly(_db.cardTags)
        ..addColumns([_db.cardTags.cardId])
        ..where(_db.cardTags.tagId.isIn(f.tagIds));
      query.where((t) => t.id.isInQuery(taggedCardIds));
    }

    switch (f.sort) {
      case CardSort.nameAsc:
        query.orderBy([(t) => OrderingTerm.asc(t.name)]);
      case CardSort.valueDesc:
        query.orderBy([(t) => OrderingTerm.desc(t.currentValue)]);
      case CardSort.quantityDesc:
        query.orderBy([(t) => OrderingTerm.desc(t.quantity)]);
      case CardSort.dateAddedDesc:
        query.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    }

    return query.watch();
  }

  Future<CardRow?> getById(int id) {
    return (_db.select(_db.cardRows)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insert(CardRowsCompanion data) => _db.into(_db.cardRows).insert(data);

  Future<void> updateCard(CardRowsCompanion data) =>
      (_db.update(_db.cardRows)..where((t) => t.id.equals(data.id.value)))
          .write(data);

  /// Deletes a card and all of its dependent rows in one transaction.
  /// (We clean up explicitly rather than relying on SQLite FK cascades,
  /// which are not emitted into the generated DDL.)
  Future<void> deleteCard(int id) {
    return _db.transaction(() async {
      await (_db.delete(_db.cardTags)..where((t) => t.cardId.equals(id))).go();
      await (_db.delete(_db.cardImages)..where((t) => t.cardId.equals(id))).go();
      await (_db.delete(_db.cardRows)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<void> setFavorite(int id, bool value) {
    return (_db.update(_db.cardRows)..where((t) => t.id.equals(id))).write(
      CardRowsCompanion(
        isFavorite: Value(value),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> setStatus(int id, String status) {
    return (_db.update(_db.cardRows)..where((t) => t.id.equals(id))).write(
      CardRowsCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  // ---- Reference lookups ----

  Future<int> gameIdForCode(String code) async {
    final row = await (_db.select(_db.games)..where((g) => g.code.equals(code)))
        .getSingle();
    return row.id;
  }

  Future<String> gameCodeForId(int id) async {
    final row =
        await (_db.select(_db.games)..where((g) => g.id.equals(id))).getSingle();
    return row.code;
  }

  Future<String?> setNameForId(int? setId) async {
    if (setId == null) return null;
    final row = await (_db.select(_db.cardSets)..where((s) => s.id.equals(setId)))
        .getSingleOrNull();
    return row?.name;
  }

  // ---- Image paths ----

  Future<List<CardImageRow>> imagesForCard(int cardId) {
    return (_db.select(_db.cardImages)..where((i) => i.cardId.equals(cardId)))
        .get();
  }

  Future<void> addImage(CardImagesCompanion image) =>
      _db.into(_db.cardImages).insert(image);

  // ---- Tag names / ids ----

  Future<List<String>> tagNamesForCard(int cardId) async {
    final query = _db.select(_db.tags).join([
      innerJoin(_db.cardTags, _db.cardTags.tagId.equalsExp(_db.tags.id)),
    ])
      ..where(_db.cardTags.cardId.equals(cardId));
    final rows = await query.get();
    return rows.map((r) => r.readTable(_db.tags).name).toList();
  }

  Future<List<int>> tagIdsForCard(int cardId) async {
    final rows = await (_db.select(_db.cardTags)
          ..where((t) => t.cardId.equals(cardId)))
        .get();
    return rows.map((r) => r.tagId).toList();
  }

  /// Replaces all tag associations for [cardId] with [tagIds].
  Future<void> setCardTags(int cardId, List<int> tagIds) async {
    await (_db.delete(_db.cardTags)..where((t) => t.cardId.equals(cardId))).go();
    if (tagIds.isEmpty) return;
    await _db.batch((b) {
      b.insertAll(
        _db.cardTags,
        tagIds
            .map((id) => CardTagsCompanion.insert(cardId: cardId, tagId: id))
            .toList(),
      );
    });
  }

  // ---- Sets ----

  Future<List<SetRow>> allSets() => _db.select(_db.cardSets).get();

  // ---- Aggregates (dashboard) ----

  Future<double> totalOwnedValue() async {
    final value =
        _db.cardRows.currentValue * _db.cardRows.quantity.cast<double>();
    final exp = value.sum();
    final query = _db.selectOnly(_db.cardRows)
      ..addColumns([exp])
      ..where(_db.cardRows.status.equals('owned'));
    final row = await query.getSingle();
    return row.read(exp) ?? 0;
  }

  Future<List<({String gameCode, int count, int copies})>> countsPerGame() async {
    final count = _db.cardRows.id.count();
    final copies = _db.cardRows.quantity.sum();
    final query = _db.selectOnly(_db.cardRows).join([
      innerJoin(_db.games, _db.games.id.equalsExp(_db.cardRows.gameId)),
    ])
      ..addColumns([_db.games.code, count, copies])
      ..where(_db.cardRows.status.equals('owned'))
      ..groupBy([_db.games.id]);
    final rows = await query.get();
    return rows
        .map((r) => (
              gameCode: r.read(_db.games.code)!,
              count: r.read(count) ?? 0,
              copies: r.read(copies) ?? 0,
            ),)
        .toList();
  }

  Future<({int unique, int copies})> totals() async {
    final unique = _db.cardRows.id.count();
    final copies = _db.cardRows.quantity.sum();
    final query = _db.selectOnly(_db.cardRows)
      ..addColumns([unique, copies])
      ..where(_db.cardRows.status.equals('owned'));
    final row = await query.getSingle();
    return (unique: row.read(unique) ?? 0, copies: row.read(copies) ?? 0);
  }

  // ---- Statistics aggregates ----

  Future<double> totalOwnedSpent() async {
    final exp =
        (_db.cardRows.purchasePrice * _db.cardRows.quantity.cast<double>())
            .sum();
    final query = _db.selectOnly(_db.cardRows)
      ..addColumns([exp])
      ..where(_db.cardRows.status.equals('owned'));
    return (await query.getSingle()).read(exp) ?? 0;
  }

  Future<int> distinctSetsCount() async {
    final exp = _db.cardRows.setId.count(distinct: true);
    final query = _db.selectOnly(_db.cardRows)
      ..addColumns([exp])
      ..where(_db.cardRows.status.equals('owned') &
          _db.cardRows.setId.isNotNull(),);
    return (await query.getSingle()).read(exp) ?? 0;
  }

  Future<List<({String gameCode, double value})>> valueByGame() async {
    final value =
        (_db.cardRows.currentValue * _db.cardRows.quantity.cast<double>())
            .sum();
    final query = _db.selectOnly(_db.cardRows).join([
      innerJoin(_db.games, _db.games.id.equalsExp(_db.cardRows.gameId)),
    ])
      ..addColumns([_db.games.code, value])
      ..where(_db.cardRows.status.equals('owned'))
      ..groupBy([_db.games.id]);
    final rows = await query.get();
    return rows
        .map((r) => (
              gameCode: r.read(_db.games.code)!,
              value: r.read(value) ?? 0,
            ),)
        .toList();
  }

  Future<Map<String, int>> countByRarity() async {
    final count = _db.cardRows.id.count();
    final query = _db.selectOnly(_db.cardRows)
      ..addColumns([_db.cardRows.rarity, count])
      ..where(_db.cardRows.status.equals('owned'))
      ..groupBy([_db.cardRows.rarity]);
    final rows = await query.get();
    return {
      for (final r in rows)
        (r.read(_db.cardRows.rarity) ?? 'Unknown'): r.read(count) ?? 0,
    };
  }

  Future<Map<String, int>> countByCondition() async {
    final count = _db.cardRows.id.count();
    final query = _db.selectOnly(_db.cardRows)
      ..addColumns([_db.cardRows.condition, count])
      ..where(_db.cardRows.status.equals('owned'))
      ..groupBy([_db.cardRows.condition]);
    final rows = await query.get();
    return {
      for (final r in rows)
        (r.read(_db.cardRows.condition) ?? 'NM'): r.read(count) ?? 0,
    };
  }

  Future<List<({int id, String name, double value})>> topValuable(
      int limit,) async {
    final query = _db.select(_db.cardRows)
      ..where((t) => t.status.equals('owned') & t.currentValue.isNotNull())
      ..orderBy([(t) => OrderingTerm.desc(t.currentValue)])
      ..limit(limit);
    final rows = await query.get();
    return rows
        .map((r) => (id: r.id, name: r.name, value: r.currentValue ?? 0))
        .toList();
  }
}
