import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/card.dart';

/// Grid tile representing a single card in the Collection.
class CardTile extends StatelessWidget {
  const CardTile({super.key, required this.card, this.onTap});

  final CardEntity card;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value =
        CurrencyFormatter.format(card.currentValue, currency: card.currency);
    final semanticLabel = '${card.name}, $value, '
        'quantity ${card.quantity}, condition ${card.condition.label}'
        '${card.isFavorite ? ', favorite' : ''}';

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Card(
        child: InkWell(
          onTap: onTap,
          // Children are decorative; the tile's own label describes the card.
          child: ExcludeSemantics(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _Thumb(path: card.thumbPath),
                      if (card.isFavorite)
                        const Positioned(
                          top: 6,
                          right: 6,
                          child:
                              Icon(Icons.star, color: Colors.amber, size: 20),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        CurrencyFormatter.format(
                          card.currentValue,
                          currency: card.currency,
                        ),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'x${card.quantity} · ${card.condition.code}',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    if (path == null || !File(path!).existsSync()) {
      return Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.style_outlined, size: 40),
      );
    }
    return Image.file(File(path!), fit: BoxFit.cover);
  }
}
