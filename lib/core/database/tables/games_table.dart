import 'package:drift/drift.dart';

/// Reference table of the five supported franchises (seeded on create).
@DataClassName('GameRow')
class Games extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get name => text()();
  TextColumn get iconAsset => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
