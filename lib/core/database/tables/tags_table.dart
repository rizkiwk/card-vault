import 'package:drift/drift.dart';

import 'cards_table.dart';

@DataClassName('TagRow')
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get color => text().nullable()();
  IntColumn get createdAt => integer()();
}

/// Junction table for the many-to-many relation between cards and tags.
@DataClassName('CardTagRow')
class CardTags extends Table {
  IntColumn get cardId =>
      integer().references(CardRows, #id, onDelete: KeyAction.cascade)();
  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {cardId, tagId};
}
