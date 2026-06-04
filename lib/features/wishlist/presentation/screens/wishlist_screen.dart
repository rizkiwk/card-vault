import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../collection/presentation/providers/card_providers.dart';
import '../providers/wishlist_provider.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: wishlist.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return const EmptyState(
              icon: Icons.favorite_border,
              title: 'Nothing on your wishlist',
              message: 'Add a dream card and mark it as Wishlist.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final card = list[i];
              return Card(
                child: ListTile(
                  title: Text(card.name),
                  subtitle: Text(
                    '${card.game.label}'
                    '${card.wishlistTargetPrice != null ? ' · Target ${CurrencyFormatter.format(card.wishlistTargetPrice)}' : ''}',
                  ),
                  trailing: FilledButton.tonal(
                    onPressed: () async {
                      await ref.read(markAsOwnedProvider).call(card.id!);
                    },
                    child: const Text('Got it!'),
                  ),
                  onTap: () => context.go('/collection/${card.id}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
