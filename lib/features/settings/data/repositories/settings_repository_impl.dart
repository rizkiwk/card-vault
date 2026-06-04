import '../../../../core/constants/app_constants.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsKeys {
  SettingsKeys._();
  static const themeMode = 'theme_mode';
  static const currency = 'currency';
}

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._ds);
  final SettingsLocalDataSource _ds;

  @override
  Future<String> getThemeMode() async =>
      await _ds.get(SettingsKeys.themeMode) ?? 'system';

  @override
  Future<void> setThemeMode(String mode) =>
      _ds.set(SettingsKeys.themeMode, mode);

  @override
  Future<String> getCurrency() async =>
      await _ds.get(SettingsKeys.currency) ?? AppConstants.defaultCurrency;

  @override
  Future<void> setCurrency(String currency) =>
      _ds.set(SettingsKeys.currency, currency);

  @override
  Future<void> clearAllData() => _ds.clearAllData();
}
