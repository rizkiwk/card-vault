import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/game_types.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/card_filter.dart';
import '../providers/card_providers.dart';
import '../widgets/card_tile.dart';
import '../widgets/filter_sheet.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardListProvider);
    final filter = ref.watch(cardFilterProvider);
    final notifier = ref.read(cardFilterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection'),
        actions: [
          IconButton(
            icon: Icon(filter.favoritesOnly ? Icons.star : Icons.star_border),
            tooltip: 'Favorites only',
            onPressed: notifier.toggleFavoritesOnly,
          ),
          PopupMenuButton<CardSort>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort',
            initialValue: filter.sort,
            onSelected: notifier.setSort,
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: CardSort.dateAddedDesc,
                child: Text('Newest first'),
              ),
              PopupMenuItem(value: CardSort.nameAsc, child: Text('Name (A–Z)')),
              PopupMenuItem(
                value: CardSort.valueDesc,
                child: Text('Value (high–low)'),
              ),
              PopupMenuItem(
                value: CardSort.quantityDesc,
                child: Text('Quantity (high–low)'),
              ),
            ],
          ),
          IconButton(
            icon: Badge(
              isLabelVisible: _activeFilterCount(filter) > 0,
              label: Text('${_activeFilterCount(filter)}'),
              child: const Icon(Icons.filter_list),
            ),
            tooltip: 'Filters',
            onPressed: () => FilterSheet.show(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search cards…',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: notifier.setSearch,
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    _GameChip(
                      label: 'All',
                      selected: filter.game == null,
                      onTap: () => notifier.setGame(null),
                    ),
                    ...GameType.values.map((g) => _GameChip(
                          label: g.label,
                          selected: filter.game == g,
                          onTap: () => notifier.setGame(g),
                        ),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: cards.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.style_outlined,
              title: 'No cards yet',
              message: 'Tap + to add your first card to the vault.',
              action: FilledButton.icon(
                onPressed: () => context.go('/add'),
                icon: const Icon(Icons.add),
                label: const Text('Add Card'),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.62,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final card = list[i];
              return CardTile(
                card: card,
                onTap: () => context.go('/collection/${card.id}'),
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

/// Number of active filters (excluding game chips & search), for the badge.
int _activeFilterCount(CardFilter f) {
  var n = 0;
  if (f.condition != null) n++;
  if (f.setId != null) n++;
  if (f.rarity != null && f.rarity!.isNotEmpty) n++;
  if (f.tagIds.isNotEmpty) n++;
  if (f.minValue != null || f.maxValue != null) n++;
  return n;
}

class _GameChip extends StatelessWidget {
  const _GameChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
