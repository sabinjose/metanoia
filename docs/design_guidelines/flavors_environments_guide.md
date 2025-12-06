# Flavors & Environments Guide

**Source:** [Flutter in Production - Module 3](https://pro.codewithandrea.com/flutter-in-production/03-flavors/01-intro)

This guide covers how to set up multiple environments (flavors) for your Flutter app, such as `development`, `staging`, and `production`.

## 1. Concepts

*   **Flavors:** Build-time configurations. Used to change the App ID (`com.example.app.dev` vs `com.example.app`), App Name ("App Dev" vs "App"), and app icon.
*   **Dart Defines:** Runtime configurations. Passed via `--dart-define` to provide API keys, base URLs, etc.
*   **Combination:** Use Flavors for the binary differences (icons, IDs) and Dart Defines for config values.

## 2. Tool: `flutter_flavorizr`

We use the `flutter_flavorizr` package to automate the setup, as manual configuration for iOS and Android is complex and error-prone.

### Setup Steps

1.  **Add Dependency:**
    Add to `pubspec.yaml` under `dev_dependencies`:
    ```yaml
    dev_dependencies:
      flutter_flavorizr: ^2.2.3 # Check for latest version
    ```

2.  **Configure `pubspec.yaml`:**
    Define your flavors in `pubspec.yaml`. Example:
    ```yaml
    flavorizr:
      app:
        android:
          flavorDimensions: "flavor"
        ios:
      flavors:
        development:
          app:
            name: "App Dev"
          android:
            applicationId: "com.example.app.dev"
          ios:
            bundleId: "com.example.app.dev"
        staging:
          app:
            name: "App Staging"
          android:
            applicationId: "com.example.app.stg"
          ios:
            bundleId: "com.example.app.stg"
        production:
          app:
            name: "App"
          android:
            applicationId: "com.example.app"
          ios:
            bundleId: "com.example.app"
    ```

3.  **Run Flavorizr:**
    ```bash
    flutter pub run flutter_flavorizr
    ```
    This command will:
    *   Update Android Gradle files and Manifests.
    *   Update iOS Xcode project schemes and configurations.
    *   Generate `main_development.dart`, `main_staging.dart`, `main_production.dart`.

## 3. Launching Flavors

*   **Development:**
    ```bash
    flutter run --flavor development -t lib/main_development.dart
    ```
*   **Production:**
    ```bash
    flutter run --flavor production -t lib/main_production.dart
    ```

## 4. VS Code Launch Configuration

Create `.vscode/launch.json` to easily run different flavors:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Dev",
            "request": "launch",
            "type": "dart",
            "program": "lib/main_development.dart",
            "args": ["--flavor", "development"]
        },
        {
            "name": "Prod",
            "request": "launch",
            "type": "dart",
            "program": "lib/main_production.dart",
            "args": ["--flavor", "production"]
        }
    ]
}
```

## 5. Icons

`flutter_flavorizr` can also handle icons. Add `icon` path to your flavor config in `pubspec.yaml`:

```yaml
flavors:
  development:
    app:
      name: "App Dev"
    android:
      applicationId: "com.example.app.dev"
      icon: "assets/icons/dev_icon.png"
    ios:
      bundleId: "com.example.app.dev"
      icon: "assets/icons/dev_icon.png"
```

## Checklist

- [ ] Add `flutter_flavorizr` to `dev_dependencies`.
- [ ] Define flavors (dev, stg, prod) in `pubspec.yaml`.
- [ ] Prepare icons for each flavor.
- [ ] Run `flutter pub run flutter_flavorizr`.
- [ ] Verify `main_*.dart` files are created.
- [ ] Create VS Code launch configurations.
- [ ] Test running each flavor on Android and iOS.
