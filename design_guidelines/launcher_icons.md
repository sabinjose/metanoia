# Launcher Icons & Splash Screens Implementation Guide

**Source:** [Flutter in Production - Module 2](https://pro.codewithandrea.com/flutter-in-production/02-launcher-icons/01-intro)

This guide details the steps to implement professional launcher icons and splash screens using `flutter_launcher_icons` and `flutter_native_splash`.

## 1. Launcher Icons

### Prerequisites
- **Design Assets:**
  - **iOS:** Single flattened image (1024x1024 px), no transparency.
  - **Android Adaptive:**
    - `background.png`: Solid color or pattern (no logo).
    - `foreground.png`: Logo with transparent background.
    - **Safe Zone:** Ensure the logo in `foreground.png` is within the central 66% of the image.
      - *Rule of Thumb:* Logo size should be ~50% of canvas for Android, ~75% for iOS.

### Implementation Steps

1.  **Add Dependency:**
    Add `flutter_launcher_icons` to `dev_dependencies` in `pubspec.yaml`.

    ```yaml
    dev_dependencies:
      flutter_launcher_icons: ^0.13.1 # Check for latest version
    ```

2.  **Configuration:**
    Add the configuration to `pubspec.yaml` or a separate `flutter_launcher_icons.yaml`.

    ```yaml
    flutter_launcher_icons:
      android: "launcher_icon"
      ios: true
      image_path: "assets/icon/icon.png" # Fallback/iOS icon
      min_sdk_android: 21 # Required for adaptive icons
      adaptive_icon_background: "assets/icon/background.png" # or hex color "#FFFFFF"
      adaptive_icon_foreground: "assets/icon/foreground.png"
      
      # iOS 18+ Dark/Tinted Icon Support (Optional)
      # ios_dark_icon: "assets/icon/icon_dark.png"
      # ios_tinted_icon: "assets/icon/icon_tinted.png" 
    ```

3.  **Generate Icons:**
    Run the generation command in the terminal:

    ```bash
    dart run flutter_launcher_icons
    ```

4.  **Verification:**
    - Check `android/app/src/main/res` for `mipmap-` folders containing new icons.
    - Check `ios/Runner/Assets.xcassets/AppIcon.appiconset`.
    - Run the app on Android and iOS simulators/devices to verify appearance.

---

## 2. Splash Screens

### Prerequisites
- **Assets:**
  - Logo image (e.g., `splash.png`) centered and high resolution.
  - Background color hex code.
  - (Optional) Dark mode variants.

### Implementation Steps

1.  **Add Dependency:**
    Add `flutter_native_splash` to `dev_dependencies` in `pubspec.yaml`.

    ```yaml
    dev_dependencies:
      flutter_native_splash: ^2.4.0 # Check for latest version
    ```

2.  **Configuration:**
    Add configuration to `pubspec.yaml` or `flutter_native_splash.yaml`.

    ```yaml
    flutter_native_splash:
      color: "#ffffff"
      image: "assets/splash/splash.png"
      branding: "assets/splash/branding.png" # Optional bottom branding
      
      # Dark Mode Support
      color_dark: "#121212"
      image_dark: "assets/splash/splash_dark.png"
      branding_dark: "assets/splash/branding_dark.png"

      # Android 12+ Support
      android_12:
        image: "assets/splash/splash_android12.png"
        icon_background_color: "#ffffff"
        icon_background_color_dark: "#121212"
    ```

3.  **Generate Splash Screen:**
    Run the generation command:

    ```bash
    dart run flutter_native_splash:create
    ```

4.  **Verification:**
    - Run the app (cold start) to see the splash screen.
    - Verify on Android 12+ devices as the API behaves differently (uses the icon).

---

## 3. Design Checklist

- [ ] **Master Icon:** 1024x1024 px.
- [ ] **Android Layers:** Separated background and foreground.
- [ ] **Safe Zones:** Logo centered and not cut off by circular masks.
- [ ] **Export:** Assets saved in `assets/icon/` and `assets/splash/`.
