# Force Update Strategies Implementation Guide

**Source:** [Flutter in Production - Module 6](https://pro.codewithandrea.com/flutter-in-production/06-force-update/01-intro)

This guide details how to implement a force update mechanism to ensure users are on a supported version of the app.

## Overview

While the `upgrader` package is a common solution, it offers limited control. A more robust approach involves using a remote configuration to define the minimum required version and a helper package to enforce it.

### Core Components
1.  **`force_update_helper`:** A package to handle version comparison and show a non-dismissible update dialog.
2.  **Remote Config:** A source of truth for the minimum required version (e.g., Firebase Remote Config, GitHub Gist, or a custom backend).

## Implementation Steps

### 1. Add Dependencies

Add `force_update_helper` and a package for your chosen remote config source (e.g., `firebase_remote_config` or `http` for Gist/Backend).

```yaml
dependencies:
  force_update_helper: ^0.1.0 # Check for latest version
  package_info_plus: ^5.0.0
  url_launcher: ^6.2.0
  # Add your remote config provider, e.g.:
  # firebase_remote_config: ^4.3.0
```

### 2. Configure Remote Source

You need a JSON-like structure hosted remotely that the app can fetch.

**Structure:**
```json
{
  "minRequiredVersion": "1.0.2"
}
```

**Options:**
-   **Firebase Remote Config:** Create a parameter `min_required_version`.
-   **GitHub Gist:** Create a public Gist with a `config.json` file and get the "Raw" URL.
-   **Custom Backend:** Create an endpoint that returns the version.

### 3. Android Configuration

Update `android/app/src/main/AndroidManifest.xml` to ensure the app can query the Play Store (if needed for some update logic, though `force_update_helper` primarily directs users to the store).

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- ... -->
</manifest>
```

*(Note: Specific manifest changes for `force_update_helper` might be minimal compared to `upgrader`, but ensure internet permissions are present.)*

### 4. Implement Force Update Logic

Wrap your `MaterialApp` with the `ForceUpdateWidget` (or similar builder provided by the package).

```dart
import 'package:force_update_helper/force_update_helper.dart';

void main() async {
  // ... initialize remote config ...
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      builder: (context, child) {
        return ForceUpdateWidget(
          navigatorKey: navigatorKey, // GlobalKey<NavigatorState>
          forceUpdateClient: ForceUpdateClient(
            fetchRequiredVersion: () async {
              // Fetch from your remote source (Firebase, Gist, etc.)
              // Return the version string, e.g., "1.0.2"
              return remoteConfig.getString('min_required_version');
            },
            iosAppStoreId: '1234567890', // Your App Store ID
            androidPackageName: 'com.example.myapp', // Your Package Name
          ),
          allowCancel: false, // Set to true if you want to allow skipping (soft update)
          child: child!,
        );
      },
      // ...
    );
  }
}
```

### 5. Testing

1.  **Local Test:** Set the remote `minRequiredVersion` to be higher than your current `pubspec.yaml` version.
2.  **Run App:** The app should display a blocking dialog prompting an update.
3.  **Click Update:** Verify it opens the correct store page (or URL).

## Checklist
- [ ] Choose a remote config strategy (Firebase vs. Gist vs. Backend).
- [ ] Implement the remote config fetching logic.
- [ ] Integrate `force_update_helper` in `MaterialApp`.
- [ ] Set correct App Store ID and Package Name.
- [ ] Verify blocking behavior by manipulating the remote version.
