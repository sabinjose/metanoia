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

/// In-App Review configuration
abstract class ReviewConfig {
  /// Number of confessions before showing review prompt
  static const int confessionThreshold = 2;

  /// Number of penance completions before showing review prompt
  static const int penanceThreshold = 3;

  /// Minimum days between review prompts
  static const int minDaysBetweenPrompts = 30;
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
