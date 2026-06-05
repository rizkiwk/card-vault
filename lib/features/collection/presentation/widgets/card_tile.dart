import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/card.dart';

/// Grid tile representing a single card in the Collection. Photo is the hero;
/// a gold favorite badge and condition chip sit on the image, name + value +
/// quantity sit below.
class CardTile extends StatelessWidget {
  const CardTile({super.key, required this.card, this.onTap});

  final CardEntity card;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = CurrencyFormatter.formatCompact(
      card.currentValue,
      currency: card.currency,
    );
    final semanticLabel = '${card.name}, $value, '
        'quantity ${card.quantity}, condition ${card.condition.label}'
        '${card.isFavorite ? ', favorite' : ''}';

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Card(
        child: InkWell(
          onTap: onTap,
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
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.28),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.star_rounded,
                              color: AppColors.favorite,
                              size: 16,
                            ),
                          ),
                        ),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.42),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            card.condition.code,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w800,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                          Text(
                            '×${card.quantity}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ],
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
      // Soft neutral mesh placeholder (real cards show the user's photo).
      final scheme = Theme.of(context).colorScheme;
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.surfaceContainerHighest,
              AppColors.indigo.withValues(alpha: 0.12),
            ],
          ),
        ),
        child: Icon(
          Icons.style_outlined,
          size: 38,
          color: scheme.onSurface.withValues(alpha: 0.25),
        ),
      );
    }
    return Image.file(File(path!), fit: BoxFit.cover);
  }
}
