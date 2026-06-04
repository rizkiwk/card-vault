import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

class TagLocalDataSource {
  TagLocalDataSource(this._db);
  final AppDatabase _db;

  /// Watches tags joined with their card counts.
  Stream<List<({TagRow tag, int count})>> watchTagsWithCounts() {
    final count = _db.cardTags.cardId.count();
    final query = _db.select(_db.tags).join([
      leftOuterJoin(_db.cardTags, _db.cardTags.tagId.equalsExp(_db.tags.id)),
    ])
      ..groupBy([_db.tags.id])
      ..orderBy([OrderingTerm.asc(_db.tags.name)]);
    query.addColumns([count]);

    return query.watch().map((rows) {
      return rows
          .map((r) => (tag: r.readTable(_db.tags), count: r.read(count) ?? 0))
          .toList();
    });
  }

  Future<int> insert(String name, String? color) {
    return _db.into(_db.tags).insert(TagsCompanion.insert(
          name: name,
          color: Value(color),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),);
  }

  Future<void> rename(int id, String name) {
    return (_db.update(_db.tags)..where((t) => t.id.equals(id)))
        .write(TagsCompanion(name: Value(name)));
  }

  Future<void> setColor(int id, String color) {
    return (_db.update(_db.tags)..where((t) => t.id.equals(id)))
        .write(TagsCompanion(color: Value(color)));
  }

  /// Removes a tag and detaches it from every card in one transaction.
  Future<void> delete(int id) {
    return _db.transaction(() async {
      await (_db.delete(_db.cardTags)..where((t) => t.tagId.equals(id))).go();
      await (_db.delete(_db.tags)..where((t) => t.id.equals(id))).go();
    });
  }
}
