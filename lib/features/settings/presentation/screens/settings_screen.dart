import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'IDR', 'AUD', 'CAD'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
    final currency =
        ref.watch(currencyProvider).valueOrNull ?? AppConstants.defaultCurrency;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader('Appearance'),
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: const Text('Theme'),
            subtitle: Text(_themeLabel(themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickTheme(context, ref, themeMode),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Default currency'),
            subtitle: Text(currency),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickCurrency(context, ref, currency),
          ),
          const _SectionHeader('Organization'),
          ListTile(
            leading: const Icon(Icons.label_outline),
            title: const Text('Manage tags'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/tags'),
          ),
          const _SectionHeader('Data'),
          ListTile(
            leading: const Icon(Icons.upload_file_outlined),
            title: const Text('Export collection'),
            subtitle: const Text('Save a .cardvault backup (data + images)'),
            onTap: () => _export(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('Import collection'),
            subtitle: const Text('Replaces current data'),
            onTap: () => _import(context, ref),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever_outlined,
                color: Theme.of(context).colorScheme.error,),
            title: const Text('Clear all data'),
            onTap: () => _clearAll(context, ref),
          ),
          const _SectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            subtitle: Text('${AppConstants.appName} 1.0.0'),
          ),
          const ListTile(
            leading: Icon(Icons.shield_outlined),
            title: Text('Privacy'),
            subtitle: Text('100% offline · no account · data stays on device'),
          ),
        ],
      ),
    );
  }

  String _themeLabel(ThemeMode m) => switch (m) {
        ThemeMode.light => 'Light',
        ThemeMode.dark => 'Dark',
        ThemeMode.system => 'System',
      };

  Future<void> _pickTheme(
      BuildContext context, WidgetRef ref, ThemeMode current,) async {
    final picked = await showModalBottomSheet<ThemeMode>(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final m in ThemeMode.values)
            ListTile(
              title: Text(_themeLabel(m)),
              trailing: m == current ? const Icon(Icons.check) : null,
              onTap: () => Navigator.pop(context, m),
            ),
        ],
      ),
    );
    if (picked != null) {
      await ref.read(themeModeProvider.notifier).setMode(picked);
    }
  }

  Future<void> _pickCurrency(
      BuildContext context, WidgetRef ref, String current,) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          for (final c in _currencies)
            ListTile(
              title: Text(c),
              trailing: c == current ? const Icon(Icons.check) : null,
              onTap: () => Navigator.pop(context, c),
            ),
        ],
      ),
    );
    if (picked != null) {
      await ref.read(currencyProvider.notifier).setCurrency(picked);
    }
  }

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final path = await ref.read(backupServiceProvider).export();
      await Share.shareXFiles([XFile(path)], subject: 'CardVault backup');
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Export failed: $e')));
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await _confirm(
      context,
      title: 'Import backup?',
      message: 'This will replace your current collection. Continue?',
      confirmLabel: 'Import',
    );
    if (!confirmed) return;

    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    final path = result?.files.single.path;
    if (path == null) return;

    try {
      await ref.read(backupServiceProvider).import(path);
      // drift's reactive streams refresh the UI automatically after commit.
      messenger.showSnackBar(const SnackBar(content: Text('Import complete.')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Import failed: $e')));
    }
  }

  Future<void> _clearAll(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await _confirm(
      context,
      title: 'Clear all data?',
      message: 'Every card, tag and set will be permanently deleted.',
      confirmLabel: 'Delete everything',
    );
    if (!confirmed) return;

    await ref.read(settingsRepositoryProvider).clearAllData();
    messenger.showSnackBar(const SnackBar(content: Text('All data cleared.')));
  }

  Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
  }) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return ok ?? false;
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
