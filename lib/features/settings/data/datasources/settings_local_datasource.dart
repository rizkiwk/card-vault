import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

/// Key-value access to the `app_settings` table, plus whole-DB maintenance
/// helpers (clear-all, raw export/import) used by Data-Safety features.
class SettingsLocalDataSource {
  SettingsLocalDataSource(this._db);
  final AppDatabase _db;

  Future<String?> get(String key) async {
    final row = await (_db.select(_db.appSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> set(String key, String value) {
    return _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingRow(key: key, value: value),
        );
  }

  /// Wipes all user content (cards, images, tags, sets) but keeps the seeded
  /// games and any app settings.
  Future<void> clearAllData() {
    return _db.transaction(() async {
      await _db.delete(_db.cardTags).go();
      await _db.delete(_db.cardImages).go();
      await _db.delete(_db.cardRows).go();
      await _db.delete(_db.tags).go();
      await _db.delete(_db.cardSets).go();
    });
  }

  // ---- Raw export ----

  Future<Map<String, dynamic>> exportData() async {
    final cards = await _db.select(_db.cardRows).get();
    final sets = await _db.select(_db.cardSets).get();
    final tags = await _db.select(_db.tags).get();
    final cardTags = await _db.select(_db.cardTags).get();
    final images = await _db.select(_db.cardImages).get();
    final games = await _db.select(_db.games).get();

    return {
      'version': 1,
      'games': games.map((g) => {'id': g.id, 'code': g.code}).toList(),
      'sets': sets
          .map((s) => {
                'id': s.id,
                'gameId': s.gameId,
                'name': s.name,
                'code': s.code,
                'releaseYear': s.releaseYear,
                'totalCards': s.totalCards,
              },)
          .toList(),
      'tags': tags
          .map((t) => {'id': t.id, 'name': t.name, 'color': t.color})
          .toList(),
      'cards': cards.map(_cardToJson).toList(),
      'cardTags': cardTags
          .map((ct) => {'cardId': ct.cardId, 'tagId': ct.tagId})
          .toList(),
      'images': images
          .map((im) => {
                'cardId': im.cardId,
                'filePath': im.filePath,
                'isPrimary': im.isPrimary,
                'side': im.side,
              },)
          .toList(),
    };
  }

  Map<String, dynamic> _cardToJson(CardRow c) => {
        'id': c.id,
        'gameId': c.gameId,
        'setId': c.setId,
        'name': c.name,
        'cardNumber': c.cardNumber,
        'rarity': c.rarity,
        'condition': c.condition,
        'quantity': c.quantity,
        'status': c.status,
        'isFavorite': c.isFavorite,
        'purchasePrice': c.purchasePrice,
        'currentValue': c.currentValue,
        'currency': c.currency,
        'wishlistPriority': c.wishlistPriority,
        'wishlistTargetPrice': c.wishlistTargetPrice,
        'language': c.language,
        'isGraded': c.isGraded,
        'grade': c.grade,
        'notes': c.notes,
        'createdAt': c.createdAt,
        'updatedAt': c.updatedAt,
      };

  // ---- Raw import (replaces existing content) ----

  /// Imports a previously-exported payload. [pathRemap] maps the original
  /// image paths to their new on-device locations after extraction.
  Future<void> importData(
    Map<String, dynamic> data, {
    Map<String, String> pathRemap = const {},
  }) async {
    await _db.transaction(() async {
      await clearAllData();

      // Sets — preserve original ids so cards/links resolve.
      for (final s in (data['sets'] as List? ?? [])) {
        await _db.into(_db.cardSets).insert(
              CardSetsCompanion.insert(
                id: Value(s['id'] as int),
                gameId: s['gameId'] as int,
                name: s['name'] as String,
                code: Value(s['code'] as String?),
                releaseYear: Value(s['releaseYear'] as int?),
                totalCards: Value(s['totalCards'] as int?),
              ),
            );
      }

      for (final t in (data['tags'] as List? ?? [])) {
        await _db.into(_db.tags).insert(
              TagsCompanion.insert(
                id: Value(t['id'] as int),
                name: t['name'] as String,
                color: Value(t['color'] as String?),
                createdAt: DateTime.now().millisecondsSinceEpoch,
              ),
            );
      }

      for (final c in (data['cards'] as List? ?? [])) {
        await _db
            .into(_db.cardRows)
            .insert(_cardCompanionFromJson(c as Map<String, dynamic>));
      }

      for (final ct in (data['cardTags'] as List? ?? [])) {
        await _db.into(_db.cardTags).insert(
              CardTagsCompanion.insert(
                cardId: ct['cardId'] as int,
                tagId: ct['tagId'] as int,
              ),
            );
      }

      for (final im in (data['images'] as List? ?? [])) {
        final original = im['filePath'] as String;
        await _db.into(_db.cardImages).insert(
              CardImagesCompanion.insert(
                cardId: im['cardId'] as int,
                filePath: pathRemap[original] ?? original,
                isPrimary: Value(im['isPrimary'] as bool? ?? false),
                side: Value(im['side'] as String? ?? 'front'),
                createdAt: DateTime.now().millisecondsSinceEpoch,
              ),
            );
      }
    });
  }

  CardRowsCompanion _cardCompanionFromJson(Map<String, dynamic> c) {
    return CardRowsCompanion.insert(
      id: Value(c['id'] as int),
      gameId: c['gameId'] as int,
      setId: Value(c['setId'] as int?),
      name: c['name'] as String,
      cardNumber: Value(c['cardNumber'] as String?),
      rarity: Value(c['rarity'] as String?),
      condition: Value(c['condition'] as String? ?? 'NM'),
      quantity: Value(c['quantity'] as int? ?? 1),
      status: Value(c['status'] as String? ?? 'owned'),
      isFavorite: Value(c['isFavorite'] as bool? ?? false),
      purchasePrice: Value((c['purchasePrice'] as num?)?.toDouble()),
      currentValue: Value((c['currentValue'] as num?)?.toDouble()),
      currency: Value(c['currency'] as String? ?? 'USD'),
      wishlistPriority: Value(c['wishlistPriority'] as int?),
      wishlistTargetPrice: Value((c['wishlistTargetPrice'] as num?)?.toDouble()),
      language: Value(c['language'] as String?),
      isGraded: Value(c['isGraded'] as bool? ?? false),
      grade: Value(c['grade'] as String?),
      notes: Value(c['notes'] as String?),
      createdAt: c['createdAt'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      updatedAt: c['updatedAt'] as int? ?? DateTime.now().millisecondsSinceEpoch,
    );
  }
}
