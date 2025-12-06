# Error Monitoring Guide (Sentry & Crashlytics)

**Source:** [Flutter in Production - Module 4](https://pro.codewithandrea.com/flutter-in-production/04-error-monitoring/01-intro)

This guide covers setting up error monitoring to capture crashes and exceptions in production, using Sentry and Firebase Crashlytics.

## 1. Why Error Monitoring?

In development, we use debuggers and logs. In production, we need tools to:
*   Capture uncaught exceptions (crashes).
*   Capture handled exceptions (e.g., failed HTTP requests).
*   Provide stack traces, device info, and user context.
*   Alert us when issues occur.

## 2. Tool Comparison: Sentry vs. Crashlytics

| Feature | Sentry | Firebase Crashlytics |
| :--- | :--- | :--- |
| **Platforms** | Mobile, Web, Desktop, Backend | Mobile (iOS/Android) only |
| **Setup** | Easy (DSN) | Requires Firebase project setup |
| **Cost** | Free tier, then paid | Free |
| **Features** | Error monitoring, Performance, Replay, Feedback | Crash reporting, Analytics integration |
| **Self-Hosted** | Yes (Open Source) | No |

**Recommendation:** Use **Sentry** for comprehensive monitoring across all platforms (especially if you have a web app). Use **Crashlytics** if you are already deep in the Firebase ecosystem and only target mobile.

## 3. Sentry Setup

### 3.1. Installation

Add `sentry_flutter` to your `pubspec.yaml`:

```yaml
dependencies:
  sentry_flutter: ^8.0.0 # Check for latest version
```

### 3.2. Initialization

Initialize Sentry in your `main.dart`. The `SentryFlutter.init` method sets up the global error handler and zone guard.

```dart
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_DSN_HERE';
      options.tracesSampleRate = 1.0; // Capture 100% of transactions for performance monitoring.
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

### 3.3. Handling Flavors & Environments

Don't hardcode the DSN. Use `--dart-define` or environment variables.

1.  **Store DSN in `.env` files:**
    ```properties
    # .env.dev
    SENTRY_DSN=https://examplePublicKey@o0.ingest.sentry.io/0
    ```
2.  **Load at build time:**
    Use `--dart-define-from-file=.env.dev` when building/running.
3.  **Configure in Code:**
    ```dart
    options.dsn = const String.fromEnvironment('SENTRY_DSN');
    options.environment = const String.fromEnvironment('FLAVOR'); // e.g., 'production', 'staging'
    ```

### 3.4. Uploading Debug Symbols (dSYMs) & Source Maps

For release builds (especially on iOS and Web), stack traces will be obfuscated. You need to upload symbols to Sentry.

*   **iOS:** Sentry's `flutter pub run flutter_flavorizr` or manual build phase script handles dSYM upload.
*   **Android:** The Sentry Gradle plugin automates ProGuard mapping upload.
*   **Web:** Use `sentry-cli` to upload source maps.

## 4. Capturing Errors Explicitly

Don't just rely on crashes. Capture handled errors in `try-catch` blocks:

```dart
try {
  await api.fetchData();
} catch (e, stackTrace) {
  await Sentry.captureException(
    e,
    stackTrace: stackTrace,
  );
}
```

## 5. User Feedback

Sentry allows collecting user feedback when an error occurs.

```dart
import 'package:sentry_flutter/sentry_flutter.dart';

// Trigger the feedback dialog
Sentry.captureMessage('User Feedback');
// Or use the dedicated widget/API provided by the `feedback` package or Sentry's built-in tools.
```

## 6. Minimizing Costs

*   **Sample Rate:** Reduce `tracesSampleRate` (e.g., to 0.1 for 10%) in production to save quota.
*   **Remote Config:** Use Firebase Remote Config to adjust the sample rate dynamically without releasing a new app version.

## Checklist

- [ ] Create Sentry account and project.
- [ ] Add `sentry_flutter` dependency.
- [ ] Initialize Sentry in `main.dart` with `appRunner`.
- [ ] Configure DSN and Environment via `dart-define`.
- [ ] Verify error reporting in dev and prod flavors.
- [ ] Set up dSYM/Source Map upload for release builds.
- [ ] (Optional) Implement User Feedback widget.
