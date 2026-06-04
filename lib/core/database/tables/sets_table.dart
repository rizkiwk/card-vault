import 'package:drift/drift.dart';

import 'games_table.dart';

/// Card sets / expansions. User-created on the fly (no online catalog).
@DataClassName('SetRow')
class CardSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gameId => integer().references(Games, #id)();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  IntColumn get releaseYear => integer().nullable()();
  IntColumn get totalCards => integer().nullable()();
}
