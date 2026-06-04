import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../collection/presentation/providers/card_providers.dart';
import '../../domain/entities/collection_stats.dart';

/// Full analytics, recomputed whenever the collection changes.
final statisticsProvider = FutureProvider<CollectionStats>((ref) {
  ref.watch(cardListProvider); // invalidate on any card write
  return ref.watch(cardRepositoryProvider).getStatistics();
});
