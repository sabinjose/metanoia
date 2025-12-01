# In-App Reviews Implementation Guide

**Source:** [Flutter in Production - Module 7](https://pro.codewithandrea.com/flutter-in-production/07-in-app-review/01-intro)

This guide details how to implement in-app reviews to encourage users to rate the app without leaving it.

## Overview

The `in_app_review` package provides a cross-platform API to request reviews. There are two main approaches:
1.  **In-App Review Pop-up (`requestReview`):** The system displays a rating dialog within the app. This is the preferred method for higher conversion.
2.  **Store Listing (`openStoreListing`):** Deep links the user to the app's page on the App Store or Play Store.

## Implementation Steps

### 1. Add Dependency

Add `in_app_review` to `pubspec.yaml`.

```yaml
dependencies:
  in_app_review: ^2.0.9 # Check for latest version
```

### 2. Usage

#### Option A: Programmatic Request (Recommended)

Trigger the review prompt after a positive user interaction (e.g., completing a level, marking a task as done).

```dart
import 'package:in_app_review/in_app_review.dart';

final InAppReview inAppReview = InAppReview.instance;

Future<void> requestReview() async {
  if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  }
}
```

**Best Practices for Timing:**
-   **Do:** Ask after a "happy moment" (success state).
-   **Don't:** Ask immediately on app launch or during a critical task.
-   **Frequency:** The OS limits how often this dialog appears (e.g., iOS limits it to 3 times per year). You don't need to track this manually; the OS handles it.

#### Option B: Manual Link (Settings Page)

Provide a button in your app's settings for users who want to leave a review manually.

```dart
import 'package:in_app_review/in_app_review.dart';

final InAppReview inAppReview = InAppReview.instance;

Future<void> openStore() async {
  inAppReview.openStoreListing(
    appStoreId: 'YOUR_APP_STORE_ID', // Required for iOS
    microsoftStoreId: '...', // If applicable
  );
}
```

## Checklist

- [ ] Add `in_app_review` dependency.
- [ ] Identify "happy paths" in the app for triggering the prompt.
- [ ] Implement `requestReview()` logic at those moments.
- [ ] Add a "Rate this App" button in Settings using `openStoreListing()`.
- [ ] Test on real devices (simulators may not show the native dialog).
