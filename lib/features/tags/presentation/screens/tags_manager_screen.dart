import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/tag.dart';
import '../../domain/usecases/tag_usecases.dart';
import '../providers/tag_providers.dart';

class TagsManagerScreen extends ConsumerWidget {
  const TagsManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Tags')),
      body: tags.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return const EmptyState(
              icon: Icons.label_outline,
              title: 'No tags yet',
              message: 'Create tags to organize your collection.',
            );
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final tag = list[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _parseColor(tag.color, context),
                  radius: 12,
                ),
                title: Text('#${tag.name}'),
                subtitle: Text('${tag.cardCount} card(s)'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _editDialog(context, ref, tag),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _confirmDelete(context, ref, tag),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editDialog(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _parseColor(String? hex, BuildContext context) {
    if (hex == null) return Theme.of(context).colorScheme.primary;
    final value = int.tryParse(hex.replaceFirst('#', 'FF'), radix: 16);
    return value != null ? Color(value) : Theme.of(context).colorScheme.primary;
  }

  Future<void> _editDialog(
    BuildContext context,
    WidgetRef ref,
    TagEntity? existing,
  ) async {
    final controller = TextEditingController(text: existing?.name ?? '');
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'New Tag' : 'Rename Tag'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Tag name',
            prefixText: '#',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;

    final repo = ref.read(tagRepositoryProvider);
    final result = existing == null
        ? await CreateTag(repo).call(name)
        : await RenameTag(repo).call(existing.id!, name);
    if (context.mounted) {
      result.fold(
        (f) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(f.message))),
        (_) {},
      );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    TagEntity tag,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete #${tag.name}?'),
        content: Text(
          tag.cardCount > 0
              ? 'This tag is on ${tag.cardCount} card(s). It will be removed from all of them.'
              : 'This cannot be undone.',
        ),
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
    if (ok == true) {
      await DeleteTag(ref.read(tagRepositoryProvider)).call(tag.id!);
    }
  }
}
