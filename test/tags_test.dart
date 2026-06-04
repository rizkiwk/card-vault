import 'package:card_vault/core/constants/game_types.dart';
import 'package:card_vault/core/database/app_database.dart';
import 'package:card_vault/core/utils/result.dart';
import 'package:card_vault/features/collection/data/datasources/card_local_datasource.dart';
import 'package:card_vault/features/collection/data/repositories/card_repository_impl.dart';
import 'package:card_vault/features/collection/domain/entities/card.dart';
import 'package:card_vault/features/collection/domain/entities/card_filter.dart';
import 'package:card_vault/features/tags/data/datasources/tag_local_datasource.dart';
import 'package:card_vault/features/tags/data/repositories/tag_repository_impl.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CardRepositoryImpl cardRepo;
  late TagRepositoryImpl tagRepo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    cardRepo = CardRepositoryImpl(CardLocalDataSource(db));
    tagRepo = TagRepositoryImpl(TagLocalDataSource(db));
  });

  tearDown(() => db.close());

  test('create tag is unique', () async {
    final ok = await tagRepo.create('vintage');
    expect(ok, isA<Success<int>>());
    final dup = await tagRepo.create('vintage');
    expect(dup, isA<Err<int>>());
  });

  test('card carries assigned tags and filters by them', () async {
    final tagId = (await tagRepo.create('grail') as Success<int>).value;

    await cardRepo.add(CardEntity(
      game: GameType.pokemon,
      name: 'Charizard',
      tagIds: [tagId],
    ),);
    await cardRepo.add(const CardEntity(
      game: GameType.pokemon,
      name: 'Pikachu',
    ),);

    // No filter → both cards.
    final all = await cardRepo.watchCards(const CardFilter()).first;
    expect(all, hasLength(2));

    // Tag filter → only Charizard.
    final filtered =
        await cardRepo.watchCards(CardFilter(tagIds: [tagId])).first;
    expect(filtered, hasLength(1));
    expect(filtered.first.name, 'Charizard');
    expect(filtered.first.tags, contains('grail'));
  });

  test('deleting a tag removes it from cards (cascade)', () async {
    final tagId = (await tagRepo.create('temp') as Success<int>).value;
    await cardRepo.add(CardEntity(
      game: GameType.mtg,
      name: 'Island',
      tagIds: [tagId],
    ),);

    await tagRepo.delete(tagId);

    final cards = await cardRepo.watchCards(const CardFilter()).first;
    expect(cards.first.tagIds, isEmpty);
    expect(cards.first.tags, isEmpty);
  });
}
