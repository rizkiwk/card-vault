import 'package:card_vault/core/constants/game_types.dart';
import 'package:card_vault/core/database/app_database.dart';
import 'package:card_vault/features/collection/data/datasources/card_local_datasource.dart';
import 'package:card_vault/features/collection/data/repositories/card_repository_impl.dart';
import 'package:card_vault/features/collection/domain/entities/card.dart';
import 'package:card_vault/features/collection/domain/entities/card_filter.dart';
import 'package:card_vault/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:card_vault/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:card_vault/features/tags/data/datasources/tag_local_datasource.dart';
import 'package:card_vault/features/tags/data/repositories/tag_repository_impl.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CardRepositoryImpl cardRepo;
  late TagRepositoryImpl tagRepo;
  late SettingsLocalDataSource settingsDs;
  late SettingsRepositoryImpl settingsRepo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    cardRepo = CardRepositoryImpl(CardLocalDataSource(db));
    tagRepo = TagRepositoryImpl(TagLocalDataSource(db));
    settingsDs = SettingsLocalDataSource(db);
    settingsRepo = SettingsRepositoryImpl(settingsDs);
  });

  tearDown(() => db.close());

  test('theme + currency persist as key-value', () async {
    expect(await settingsRepo.getThemeMode(), 'system'); // default
    await settingsRepo.setThemeMode('dark');
    expect(await settingsRepo.getThemeMode(), 'dark');

    await settingsRepo.setCurrency('EUR');
    expect(await settingsRepo.getCurrency(), 'EUR');
  });

  test('clearAllData wipes content but keeps seeded games', () async {
    await cardRepo.add(const CardEntity(game: GameType.mtg, name: 'Island'));
    await settingsRepo.clearAllData();

    final cards = await cardRepo.watchCards(const CardFilter()).first;
    expect(cards, isEmpty);
    // Games remain so the app can still add cards.
    final summary = await cardRepo.getSummary();
    expect(summary.perGame, isEmpty); // no cards, but games table intact
  });

  test('export → clear → import restores cards and tags', () async {
    final tagId = await tagRepo.create('grail').then((r) => r.valueOrNull!);
    await cardRepo.add(CardEntity(
      game: GameType.pokemon,
      name: 'Charizard',
      currentValue: 320,
      tagIds: [tagId],
    ),);

    final exported = await settingsDs.exportData();
    expect((exported['cards'] as List), hasLength(1));

    await settingsRepo.clearAllData();
    expect(await cardRepo.watchCards(const CardFilter()).first, isEmpty);

    await settingsDs.importData(exported);

    final restored = await cardRepo.watchCards(const CardFilter()).first;
    expect(restored, hasLength(1));
    expect(restored.first.name, 'Charizard');
    expect(restored.first.tags, contains('grail'));
  });
}
