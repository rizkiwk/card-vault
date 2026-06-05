import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/backup_service.dart';
import '../../../../shared/providers/database_provider.dart';
import '../../data/datasources/settings_local_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';

// ---- Infrastructure ----

final settingsLocalDataSourceProvider =
    Provider<SettingsLocalDataSource>((ref) {
  return SettingsLocalDataSource(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.watch(settingsLocalDataSourceProvider));
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(settingsLocalDataSourceProvider));
});

// ---- Theme ----

ThemeMode _parseTheme(String s) => switch (s) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

String _themeToString(ThemeMode m) => switch (m) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final repo = ref.watch(settingsRepositoryProvider);
    return _parseTheme(await repo.getThemeMode());
  }

  Future<void> setMode(ThemeMode mode) async {
    state = AsyncData(mode);
    await ref
        .read(settingsRepositoryProvider)
        .setThemeMode(_themeToString(mode));
  }
}

final themeModeProvider =
    AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

// ---- Currency ----

class CurrencyNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    return ref.watch(settingsRepositoryProvider).getCurrency();
  }

  Future<void> setCurrency(String currency) async {
    state = AsyncData(currency);
    await ref.read(settingsRepositoryProvider).setCurrency(currency);
  }
}

final currencyProvider =
    AsyncNotifierProvider<CurrencyNotifier, String>(CurrencyNotifier.new);
