import 'package:drift/drift.dart';

/// Simple key-value store for user preferences (theme, currency, …).
@DataClassName('AppSettingRow')
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
