import 'package:card_vault/core/constants/game_types.dart';
import 'package:card_vault/core/database/app_database.dart';
import 'package:card_vault/core/utils/result.dart';
import 'package:card_vault/features/collection/data/datasources/card_local_datasource.dart';
import 'package:card_vault/features/collection/data/repositories/card_repository_impl.dart';
import 'package:card_vault/features/collection/domain/entities/card.dart';
import 'package:card_vault/features/collection/domain/entities/card_filter.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CardRepositoryImpl repo;

  setUp(() async {
    // forTesting still runs the migration's onCreate, which seeds the 5 games.
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = CardRepositoryImpl(CardLocalDataSource(db));
  });

  tearDown(() => db.close());

  test('add then watch returns the card', () async {
    final result = await repo.add(const CardEntity(
      game: GameType.pokemon,
      name: 'Charizard',
      currentValue: 320,
      quantity: 2,
    ),);

    expect(result, isA<Success<int>>());

    final cards =
        await repo.watchCards(const CardFilter()).first;
    expect(cards, hasLength(1));
    expect(cards.first.name, 'Charizard');
    expect(cards.first.totalValue, 640);
  });

  test('summary aggregates owned value', () async {
    await repo.add(const CardEntity(
      game: GameType.mtg,
      name: 'Black Lotus',
      currentValue: 8000,
    ),);
    final summary = await repo.getSummary();
    expect(summary.totalValue, 8000);
    expect(summary.uniqueCards, 1);
  });

  test('toggleFavorite flips the flag', () async {
    final id = (await repo.add(const CardEntity(
      game: GameType.yugioh,
      name: 'Blue-Eyes',
    ),) as Success<int>)
        .value;

    await repo.toggleFavorite(id);
    final card = (await repo.getById(id)).valueOrNull!;
    expect(card.isFavorite, isTrue);
  });
}
