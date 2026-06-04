/// Contract for user preferences and destructive data operations.
abstract interface class SettingsRepository {
  Future<String> getThemeMode(); // 'system' | 'light' | 'dark'
  Future<void> setThemeMode(String mode);

  Future<String> getCurrency();
  Future<void> setCurrency(String currency);

  /// Removes all user content (cards, images metadata, tags, sets).
  Future<void> clearAllData();
}
