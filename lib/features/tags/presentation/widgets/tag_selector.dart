import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/tag_usecases.dart';
import '../providers/tag_providers.dart';

/// A wrap of selectable tag chips plus an inline "create tag" action.
/// Controlled: parent owns [selected] and reacts to [onChanged].
class TagSelector extends ConsumerWidget {
  const TagSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final List<int> selected;
  final ValueChanged<List<int>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsProvider);

    return tags.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (list) {
        return Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...list.map((tag) {
              final isSel = selected.contains(tag.id);
              return FilterChip(
                label: Text('#${tag.name}'),
                selected: isSel,
                onSelected: (_) {
                  final next = [...selected];
                  isSel ? next.remove(tag.id) : next.add(tag.id!);
                  onChanged(next);
                },
              );
            }),
            ActionChip(
              avatar: const Icon(Icons.add, size: 18),
              label: const Text('New'),
              onPressed: () => _createTag(context, ref),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createTag(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Tag'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(prefixText: '#', hintText: 'name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;

    final result = await CreateTag(ref.read(tagRepositoryProvider)).call(name);
    result.fold(
      (f) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(f.message)));
        }
      },
      (id) => onChanged([...selected, id]),
    );
  }
}
