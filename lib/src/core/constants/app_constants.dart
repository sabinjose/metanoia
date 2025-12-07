/// Central configuration file for app constants
///
/// This file contains all configurable values that may need to be updated
/// when publishing or configuring the app.
library;

/// App Store and Play Store configuration
abstract class StoreConfig {
  /// Apple App Store ID (found in App Store Connect → App Information → Apple ID)
  /// Update this when the app is published to the App Store
  static const String appStoreId = ''; // TODO: Add App Store ID when available

  /// Google Play Store package name (automatically detected from AndroidManifest.xml)
  /// Only needed if different from the app's package name
  static const String? playStorePackageName = null;
}

/// App Update configuration
abstract class UpdateConfig {
  /// Minimum app version required - versions below this will be forced to update
  static const String minAppVersion = '1.0.0';

  /// Days to wait before showing the update prompt again
  static const int daysUntilAlertAgain = 3;
}

/// In-App Review configuration
abstract class ReviewConfig {
  /// Number of confessions before showing review prompt
  static const int confessionThreshold = 2;

  /// Number of penance completions before showing review prompt
  static const int penanceThreshold = 3;

  /// Minimum days between review prompts
  static const int minDaysBetweenPrompts = 30;
}

/// Supported Languages configuration
abstract class LanguageConfig {
  /// All supported content languages with their display names
  /// Add new languages here when adding translations
  /// Format: {'code': 'Display Name'}
  static const Map<String, String> supportedContentLanguages = {
    'en': 'English',
    'ml': 'മലയാളം',
    'es': 'Español',
    'pt': 'Português',
    'fr': 'Français',
  };

  /// Get list of language codes only (for database sync)
  static List<String> get languageCodes =>
      supportedContentLanguages.keys.toList();

  /// Default content language
  static const String defaultContentLanguage = 'en';
}

/// App URLs and links
abstract class AppUrls {
  /// GitHub repository URL
  static const String githubRepo = 'https://github.com/sabinjose/confessionapp';

  /// App share message
  static const String shareMessage =
      'Check out Metanoia: Catholic Confession App! https://github.com/sabinjose/confessionapp';
  // TODO: Update with actual website/store URL when available
}
