// The `quantity` CHECK constraint references its own column — a standard drift
// idiom that the generator reads statically and never executes at runtime.
// ignore_for_file: recursive_getters
import 'package:drift/drift.dart';

import 'games_table.dart';
import 'sets_table.dart';

/// Core card entity table.
///
/// The generated row class is named `CardRow` to avoid clashing with the
/// pure-domain `Card` entity.
@DataClassName('CardRow')
class CardRows extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gameId => integer().references(Games, #id)();
  IntColumn get setId => integer().nullable().references(CardSets, #id)();

  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get cardNumber => text().nullable()();
  TextColumn get rarity => text().nullable()();
  TextColumn get condition => text().withDefault(const Constant('NM'))();

  IntColumn get quantity => integer()
      .withDefault(const Constant(1))
      .check(quantity.isBiggerOrEqualValue(0))();
  TextColumn get status => text().withDefault(const Constant('owned'))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  RealColumn get purchasePrice => real().nullable()();
  RealColumn get currentValue => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();

  IntColumn get wishlistPriority => integer().nullable()();
  RealColumn get wishlistTargetPrice => real().nullable()();

  TextColumn get language => text().nullable()();
  BoolColumn get isGraded => boolean().withDefault(const Constant(false))();
  TextColumn get grade => text().nullable()();
  TextColumn get notes => text().nullable()();

  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}
