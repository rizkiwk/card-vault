/// App-wide constant values.
class AppConstants {
  AppConstants._();

  static const String appName = 'CardVault';
  static const String dbFileName = 'card_vault.sqlite';

  /// Directory (under app documents) where card images are persisted.
  static const String imagesDir = 'card_images';

  /// Max width/height for stored full images (compression target).
  static const int maxImageDimension = 1600;

  /// Thumbnail size used in lists.
  static const int thumbnailDimension = 256;

  static const String defaultCurrency = 'USD';
}
