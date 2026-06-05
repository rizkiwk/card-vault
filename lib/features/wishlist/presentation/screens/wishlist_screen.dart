import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_widgets.dart';
import '../../../collection/domain/entities/card.dart';
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
            return EmptyState(
              icon: Icons.auto_awesome,
              title: 'Nothing on your wishlist',
              message:
                  "Add the cards you're chasing and track them toward a target price.",
              action: GradientButton(
                onPressed: () => context.go('/add'),
                icon: Icons.add,
                label: 'Add a dream card',
                expand: false,
              ),
            );
          }

          final target = list.fold<double>(
            0,
            (sum, c) => sum + (c.wishlistTargetPrice ?? 0),
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _TargetBanner(total: target),
              const SizedBox(height: 16),
              ...list.map(
                (card) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _WishCard(
                    card: card,
                    onGotIt: () => ref.read(markAsOwnedProvider).call(card.id!),
                    onTap: () => context.go('/collection/${card.id}'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: GradientFab(
        onPressed: () => context.go('/add'),
        tooltip: 'Add Card',
      ),
    );
  }
}

class _TargetBanner extends StatelessWidget {
  const _TargetBanner({required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Target total', style: theme.textTheme.labelMedium),
                const SizedBox(height: 2),
                Text(
                  CurrencyFormatter.formatCompact(total),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.savings_outlined,
            size: 32,
            color: AppColors.accentStart,
          ),
        ],
      ),
    );
  }
}

class _WishCard extends StatelessWidget {
  const _WishCard({
    required this.card,
    required this.onGotIt,
    required this.onTap,
  });

  final CardEntity card;
  final VoidCallback onGotIt;
  final VoidCallback onTap;

  ({String label, Color color}) get _priority =>
      switch (card.wishlistPriority) {
        1 => (label: 'High', color: AppColors.lightLoss),
        2 => (label: 'Medium', color: AppColors.warning),
        3 => (label: 'Low', color: AppColors.accentStart),
        _ => (label: 'Normal', color: AppColors.lightMuted2),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pri = _priority;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 60,
                  height: 84,
                  child: _WishThumb(path: card.thumbPath),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            card.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _PriorityChip(label: pri.label, color: pri.color),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${card.game.label}'
                      '${card.setName != null ? ' · ${card.setName}' : ''}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (card.wishlistTargetPrice != null)
                          Text(
                            'Target ${CurrencyFormatter.formatCompact(card.wishlistTargetPrice)}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        _GotItButton(onPressed: onGotIt),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style:
              Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}

class _GotItButton extends StatelessWidget {
  const _GotItButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Got it!',
              style: TextStyle(
                color: AppColors.onAccent,
                fontFamily: 'PlusJakartaSans',
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WishThumb extends StatelessWidget {
  const _WishThumb({this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    if (path != null && File(path!).existsSync()) {
      return Image.file(File(path!), fit: BoxFit.cover);
    }
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.surfaceContainerHighest,
            AppColors.violet.withValues(alpha: 0.14),
          ],
        ),
      ),
      child: Icon(
        Icons.style_outlined,
        size: 24,
        color: scheme.onSurface.withValues(alpha: 0.25),
      ),
    );
  }
}
