import 'package:card_vault/core/constants/game_types.dart';
import 'package:card_vault/core/database/app_database.dart';
import 'package:card_vault/features/collection/data/datasources/card_local_datasource.dart';
import 'package:card_vault/features/collection/data/repositories/card_repository_impl.dart';
import 'package:card_vault/features/collection/domain/entities/card.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CardRepositoryImpl repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = CardRepositoryImpl(CardLocalDataSource(db));
  });

  tearDown(() => db.close());

  test('computes gain/loss and value-by-game', () async {
    await repo.add(const CardEntity(
      game: GameType.pokemon,
      name: 'Charizard',
      purchasePrice: 180,
      currentValue: 320,
      quantity: 1,
    ),);
    await repo.add(const CardEntity(
      game: GameType.mtg,
      name: 'Black Lotus',
      purchasePrice: 5000,
      currentValue: 8000,
      quantity: 1,
    ),);

    final s = await repo.getStatistics();
    expect(s.totalValue, 8320);
    expect(s.totalSpent, 5180);
    expect(s.gainLoss, 3140);
    expect(s.valueByGame[GameType.pokemon], 320);
    expect(s.valueByGame[GameType.mtg], 8000);
    expect(s.gainLossPercent, closeTo(60.6, 0.1));
  });

  test('top valuable is ordered desc and capped', () async {
    for (var i = 1; i <= 7; i++) {
      await repo.add(CardEntity(
        game: GameType.yugioh,
        name: 'Card $i',
        currentValue: i * 10.0,
      ),);
    }
    final s = await repo.getStatistics();
    expect(s.topValuable, hasLength(5));
    expect(s.topValuable.first.value, 70);
    expect(s.topValuable.last.value, 30);
  });

  test('rarity breakdown counts cards', () async {
    await repo.add(const CardEntity(
      game: GameType.pokemon,
      name: 'A',
      rarity: 'Rare',
    ),);
    await repo.add(const CardEntity(
      game: GameType.pokemon,
      name: 'B',
      rarity: 'Rare',
    ),);
    await repo.add(const CardEntity(
      game: GameType.pokemon,
      name: 'C',
      rarity: 'Common',
    ),);
    final s = await repo.getStatistics();
    expect(s.countByRarity['Rare'], 2);
    expect(s.countByRarity['Common'], 1);
  });
}
