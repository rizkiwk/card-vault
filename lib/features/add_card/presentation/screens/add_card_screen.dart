import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/game_types.dart';
import '../../../../core/widgets/gradient_widgets.dart';
import '../../../collection/domain/entities/card.dart';
import '../../../collection/presentation/providers/card_providers.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../../../tags/presentation/widgets/tag_selector.dart';
import '../providers/add_card_controller.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key, this.editId});
  final int? editId;

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _cardNumber = TextEditingController();
  final _rarity = TextEditingController();
  final _purchase = TextEditingController();
  final _value = TextEditingController();
  final _notes = TextEditingController();

  GameType _game = GameType.pokemon;
  CardCondition _condition = CardCondition.nearMint;
  CardStatus _status = CardStatus.owned;
  int _quantity = 1;
  String? _imagePath;
  List<int> _tagIds = [];
  String? _currency;
  bool _loaded = false;

  @override
  void dispose() {
    for (final c in [_name, _cardNumber, _rarity, _purchase, _value, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _capture({required bool fromCamera}) async {
    final controller = ref.read(addCardControllerProvider.notifier);
    final path = fromCamera
        ? await controller.captureFromCamera()
        : await controller.pickFromGallery();
    if (path != null) setState(() => _imagePath = path);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final card = CardEntity(
      id: widget.editId,
      game: _game,
      name: _name.text.trim(),
      cardNumber:
          _cardNumber.text.trim().isEmpty ? null : _cardNumber.text.trim(),
      rarity: _rarity.text.trim().isEmpty ? null : _rarity.text.trim(),
      condition: _condition,
      quantity: _quantity,
      status: _status,
      purchasePrice: double.tryParse(_purchase.text),
      currentValue: double.tryParse(_value.text),
      currency: _currency ?? ref.read(currencyProvider).valueOrNull ?? 'USD',
      notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
      tagIds: _tagIds,
      imagePaths: _imagePath != null ? [_imagePath!] : const [],
    );

    final controller = ref.read(addCardControllerProvider.notifier);
    try {
      if (widget.editId != null) {
        await controller.updateExisting(card);
      } else {
        await controller.submit(card);
      }
      if (mounted) context.go('/collection');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pre-fill when editing.
    if (widget.editId != null && !_loaded) {
      final existing =
          ref.watch(cardDetailProvider(widget.editId!)).valueOrNull;
      if (existing != null) {
        _name.text = existing.name;
        _cardNumber.text = existing.cardNumber ?? '';
        _rarity.text = existing.rarity ?? '';
        _purchase.text = existing.purchasePrice?.toString() ?? '';
        _value.text = existing.currentValue?.toString() ?? '';
        _notes.text = existing.notes ?? '';
        _game = existing.game;
        _condition = existing.condition;
        _status = existing.status;
        _quantity = existing.quantity;
        _imagePath =
            existing.imagePaths.isNotEmpty ? existing.imagePaths.first : null;
        _tagIds = List<int>.from(existing.tagIds);
        _currency = existing.currency;
        _loaded = true;
      }
    }

    final saving = ref.watch(addCardControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editId != null ? 'Edit Card' : 'Add Card'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/collection'),
        ),
        actions: [
          TextButton(
            onPressed: saving ? null : _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ImagePicker(
              path: _imagePath,
              onCamera: () => _capture(fromCamera: true),
              onGallery: () => _capture(fromCamera: false),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GameType>(
              initialValue: _game,
              decoration: const InputDecoration(labelText: 'Game *'),
              items: GameType.values
                  .map((g) => DropdownMenuItem(value: g, child: Text(g.label)))
                  .toList(),
              onChanged: (g) => setState(() => _game = g!),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Card Name *'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _cardNumber,
              decoration: const InputDecoration(labelText: 'Card Number'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _rarity,
              decoration: const InputDecoration(labelText: 'Rarity'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<CardCondition>(
              initialValue: _condition,
              decoration: const InputDecoration(labelText: 'Condition *'),
              items: CardCondition.values
                  .map(
                    (c) => DropdownMenuItem(value: c, child: Text(c.label)),
                  )
                  .toList(),
              onChanged: (c) => setState(() => _condition = c!),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Quantity'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed:
                      _quantity > 0 ? () => setState(() => _quantity--) : null,
                ),
                Text(
                  '$_quantity',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _purchase,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Purchase \$'),
                    validator: _nonNegative,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _value,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Value \$'),
                    validator: _nonNegative,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notes,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('Tags', style: Theme.of(context).textTheme.titleSmall),
            ),
            const SizedBox(height: 8),
            TagSelector(
              selected: _tagIds,
              onChanged: (ids) => setState(() => _tagIds = ids),
            ),
            const SizedBox(height: 16),
            SegmentedButton<CardStatus>(
              segments: const [
                ButtonSegment(value: CardStatus.owned, label: Text('Owned')),
                ButtonSegment(
                  value: CardStatus.wishlist,
                  label: Text('Wishlist'),
                ),
              ],
              selected: {_status},
              onSelectionChanged: (s) => setState(() => _status = s.first),
            ),
            const SizedBox(height: 24),
            GradientButton(
              onPressed: saving ? null : _save,
              icon: Icons.check_rounded,
              label: saving ? 'Saving…' : 'Save Card',
            ),
          ],
        ),
      ),
    );
  }

  String? _nonNegative(String? v) {
    if (v == null || v.isEmpty) return null;
    final n = double.tryParse(v);
    if (n == null) return 'Invalid number';
    if (n < 0) return 'Cannot be negative';
    return null;
  }
}

class _ImagePicker extends StatelessWidget {
  const _ImagePicker({
    required this.path,
    required this.onCamera,
    required this.onGallery,
  });
  final String? path;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: path != null && File(path!).existsSync()
              ? Image.file(
                  File(path!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Center(child: Icon(Icons.add_a_photo_outlined, size: 48)),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: onCamera,
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Camera'),
            ),
            const SizedBox(width: 16),
            TextButton.icon(
              onPressed: onGallery,
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ],
    );
  }
}
