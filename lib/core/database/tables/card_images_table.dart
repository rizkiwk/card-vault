import 'package:drift/drift.dart';

import 'cards_table.dart';

/// Image files attached to a card. Files live in app-private storage;
/// only the relative path is stored here.
@DataClassName('CardImageRow')
class CardImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId =>
      integer().references(CardRows, #id, onDelete: KeyAction.cascade)();
  TextColumn get filePath => text()();
  TextColumn get thumbPath => text().nullable()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  TextColumn get side => text().withDefault(const Constant('front'))();
  IntColumn get createdAt => integer()();
}
