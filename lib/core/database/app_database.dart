import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import 'tables/app_settings_table.dart';
import 'tables/card_images_table.dart';
import 'tables/cards_table.dart';
import 'tables/games_table.dart';
import 'tables/sets_table.dart';
import 'tables/tags_table.dart';

part 'app_database.g.dart';

/// The single drift database for CardVault.
///
/// Run `dart run build_runner build --delete-conflicting-outputs` to
/// (re)generate `app_database.g.dart` after editing tables.
@DriftDatabase(
  tables: [
    Games,
    CardSets,
    CardRows,
    CardImages,
    Tags,
    CardTags,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  /// Convenience constructor for tests (in-memory, no file).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  /// Opens the on-device SQLite file lazily on a background isolate.
  static QueryExecutor _open() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, AppConstants.dbFileName));
      return NativeDatabase.createInBackground(file);
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedGames();
        },
        onUpgrade: (m, from, to) async {
          // v1 → v2: introduce the app_settings key-value table.
          if (from < 2) {
            await m.createTable(appSettings);
          }
        },
        beforeOpen: (details) async {
          // Enforce foreign keys on every connection (defensive; cascades are
          // also handled explicitly in the data layer).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> _seedGames() async {
    const seed = [
      (code: 'pokemon', name: 'Pokémon', order: 1),
      (code: 'onepiece', name: 'One Piece', order: 2),
      (code: 'yugioh', name: 'Yu-Gi-Oh!', order: 3),
      (code: 'mtg', name: 'Magic: The Gathering', order: 4),
      (code: 'sports', name: 'Sports Cards', order: 5),
    ];
    await batch((b) {
      b.insertAll(
        games,
        seed
            .map(
              (g) => GamesCompanion.insert(
                code: g.code,
                name: g.name,
                sortOrder: Value(g.order),
              ),
            )
            .toList(),
      );
    });
  }
}
