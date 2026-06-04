import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../collection/domain/entities/card.dart';
import '../../../collection/domain/entities/card_filter.dart';
import '../../../../core/constants/game_types.dart';
import '../../../collection/presentation/providers/card_providers.dart';

/// Reactive stream of wishlist (status='wishlist') cards.
final wishlistProvider = StreamProvider.autoDispose<List<CardEntity>>((ref) {
  final repo = ref.watch(cardRepositoryProvider);
  return repo.watchCards(const CardFilter(status: CardStatus.wishlist));
});
