import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/game_types.dart';
import '../../../tags/presentation/providers/tag_providers.dart';
import '../providers/card_providers.dart';

/// Bottom sheet exposing the full set of Collection filters.
class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const FilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(cardFilterProvider);
    final notifier = ref.read(cardFilterProvider.notifier);
    final sets = ref.watch(setsProvider);
    final tags = ref.watch(tagsProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters', style: theme.textTheme.titleLarge),
                TextButton(
                  onPressed: notifier.reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Condition
            const _Label('Condition'),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Any'),
                  selected: filter.condition == null,
                  onSelected: (_) => notifier.setCondition(null),
                ),
                ...CardCondition.values.map(
                  (c) => ChoiceChip(
                    label: Text(c.code),
                    selected: filter.condition == c,
                    onSelected: (_) => notifier.setCondition(c),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Set
            const _Label('Set'),
            sets.maybeWhen(
              data: (list) => DropdownButton<int?>(
                isExpanded: true,
                value: filter.setId,
                hint: const Text('Any set'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Any set')),
                  ...list.map(
                    (s) => DropdownMenuItem(value: s.id, child: Text(s.name)),
                  ),
                ],
                onChanged: notifier.setSetId,
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),

            // Tags
            const _Label('Tags'),
            tags.maybeWhen(
              data: (list) => Wrap(
                spacing: 8,
                children: list
                    .map(
                      (t) => FilterChip(
                        label: Text('#${t.name}'),
                        selected: filter.tagIds.contains(t.id),
                        onSelected: (_) => notifier.toggleTag(t.id!),
                      ),
                    )
                    .toList(),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),

            // Value range
            const _Label('Value range'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: filter.minValue?.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      labelText: 'Min',
                    ),
                    onChanged: (v) => notifier.setValueRange(
                      double.tryParse(v),
                      filter.maxValue,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: filter.maxValue?.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      labelText: 'Max',
                    ),
                    onChanged: (v) => notifier.setValueRange(
                      filter.minValue,
                      double.tryParse(v),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}
