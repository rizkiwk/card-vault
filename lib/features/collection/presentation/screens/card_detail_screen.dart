import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/card.dart';
import '../providers/card_providers.dart';

class CardDetailScreen extends ConsumerWidget {
  const CardDetailScreen({super.key, required this.cardId});
  final int cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(cardDetailProvider(cardId));

    return Scaffold(
      appBar: AppBar(
        title: Text(async.valueOrNull?.name ?? 'Card'),
        actions: [
          if (async.hasValue)
            IconButton(
              icon: Icon(async.value!.isFavorite
                  ? Icons.star
                  : Icons.star_border,),
              onPressed: () async {
                await ref.read(toggleFavoriteProvider).call(cardId);
                ref.invalidate(cardDetailProvider(cardId));
              },
            ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.go('/add?editId=$cardId'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (card) => _DetailBody(card: card),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete card?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true) return;

    // Clean up image files, then delete the DB row.
    final card = ref.read(cardDetailProvider(cardId)).valueOrNull;
    if (card != null && card.imagePaths.isNotEmpty) {
      await ref.read(imageStorageServiceProvider).deleteFiles(card.imagePaths);
    }
    await ref.read(deleteCardProvider).call(cardId);
    if (context.mounted) context.go('/collection');
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.card});
  final CardEntity card;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gl = card.gainLoss;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: card.imagePaths.isNotEmpty &&
                    File(card.imagePaths.first).existsSync()
                ? Image.file(File(card.imagePaths.first), fit: BoxFit.cover)
                : Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.style_outlined, size: 64),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${card.game.label}'
          '${card.setName != null ? ' · ${card.setName}' : ''}'
          '${card.cardNumber != null ? ' · #${card.cardNumber}' : ''}',
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.outline),
        ),
        const SizedBox(height: 4),
        Text(
          '${card.rarity ?? 'Unknown'} · ${card.condition.label} · x${card.quantity}',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _Stat(
                label: 'Current',
                value: CurrencyFormatter.format(card.currentValue,
                    currency: card.currency,),
              ),
            ),
            Expanded(
              child: _Stat(
                label: 'Purchased',
                value: CurrencyFormatter.format(card.purchasePrice,
                    currency: card.currency,),
              ),
            ),
          ],
        ),
        if (gl != null) ...[
          const SizedBox(height: 8),
          Text(
            'Gain/Loss: ${CurrencyFormatter.formatSigned(gl, currency: card.currency)}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: gl >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
        if (card.tags.isNotEmpty) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: card.tags
                .map((t) => Chip(label: Text('#$t')))
                .toList(),
          ),
        ],
        if (card.notes != null && card.notes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Notes', style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(card.notes!),
        ],
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(value, style: theme.textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
