# iOS App Release Guide

**Source:** [Flutter in Production - Module 9](https://pro.codewithandrea.com/flutter-in-production/09-release-ios/01-intro)

This guide covers the end-to-end process of releasing a Flutter app to the Apple App Store, from joining the developer program to submitting for review.

## 1. Apple Developer Program

*   **Requirement:** You must enroll in the [Apple Developer Program](https://developer.apple.com/programs/) ($99/year) to distribute apps on the App Store.
*   **Enrollment:**
    *   **Individual:** Easier verification, but your personal name appears as the seller.
    *   **Organization:** Requires a D-U-N-S number (can take time to get). Allows adding team members. Seller name is the organization name.
*   **Trader Status (EU):** Apple now requires you to declare if you are a "trader" (commercial entity) for EU compliance. If you earn money from the app, you are likely a trader.

## 2. App Store Connect Setup

Once enrolled, you use [App Store Connect](https://appstoreconnect.apple.com/) to manage your apps.

### Register App ID
1.  Go to **Apple Developer Portal** > **Certificates, Identifiers & Profiles** > **Identifiers**.
2.  Click **+** to create a new App ID.
3.  Select **App** > **App**.
4.  **Description:** Enter your app name.
5.  **Bundle ID:** Must match the `bundleIdentifier` in your Flutter project (e.g., `com.example.confessionapp`). **Explicit** App ID is recommended over Wildcard.
6.  **Capabilities:** Enable services you need (e.g., Push Notifications, Sign in with Apple).

### Create App in App Store Connect
1.  Go to **App Store Connect** > **My Apps**.
2.  Click **+** > **New App**.
3.  **Platform:** iOS.
4.  **Name:** Your app's public name (must be unique).
5.  **Primary Language:** e.g., English (US).
6.  **Bundle ID:** Select the one you just created.
7.  **SKU:** Internal unique ID (e.g., `confessionapp_ios`).
8.  **User Access:** Full Access.

## 3. Preparing for Review

Fill out all required metadata in App Store Connect.

*   **App Information:** Name, subtitle (optional), category, content rights, age rating.
*   **Pricing and Availability:** Price schedule (usually Free), availability (countries/regions).
*   **App Privacy:**
    *   You must disclose what data you collect (e.g., Contact Info, User Content, Identifiers).
    *   Link to your Privacy Policy (see [App Landing Page Guide](./app_landing_page.md)).
*   **Privacy Manifest:**
    *   Starting Spring 2024, apps must include a `PrivacyInfo.xcprivacy` file if they use certain "required reason APIs" (e.g., accessing user defaults, file timestamps).
    *   Declare usage reasons in this file to avoid rejection.

## 4. Xcode Configuration

Before building, ensure your Xcode project settings are correct.

*   **General:**
    *   **Display Name:** The name shown on the home screen.
    *   **Bundle Identifier:** Must match the App ID.
    *   **Version:** Marketing version (e.g., 1.0.0).
    *   **Build:** Internal build number (must increment for every upload, e.g., 1, 2, 3).
    *   **Minimum Deployments:** Set iOS Deployment Target (e.g., 16.0).
*   **Signing & Capabilities:**
    *   **Team:** Select your Apple Developer Team.
    *   **Bundle Identifier:** Verify it matches.
    *   **Automatically manage signing:** Recommended. Xcode will create certificates and profiles for you.

## 5. Building and Uploading

### Archive
1.  Open `ios/Runner.xcworkspace` in Xcode.
2.  Select **Any iOS Device (arm64)** as the build target.
3.  Go to **Product** > **Archive**.
4.  Wait for the build to complete. The **Organizer** window will open.

### Validate & Distribute
1.  In the Organizer, select your archive.
2.  Click **Distribute App**.
3.  Select **App Store Connect** > **Upload**.
4.  Keep default options (Upload your app's symbols, Manage Version and Build Number).
5.  **Automatically manage signing**.
6.  Click **Upload**.

*Alternative: Use `xcrun altool` or Transporter app if Xcode upload fails.*

## 6. TestFlight (Beta Testing)

Before releasing to the public, test with TestFlight.

1.  In App Store Connect, go to the **TestFlight** tab.
2.  Wait for the build to process (can take 10-30 mins).
3.  **Internal Testing:** Add App Store Connect users (instant access).
4.  **External Testing:** Create a group, add external testers via email or public link. Requires a quick Beta App Review (usually < 24 hours).

## 7. Submission

1.  Go to the **App Store** tab in App Store Connect.
2.  Select the version you want to submit (e.g., 1.0 Prepare for Submission).
3.  **Build:** Click **Add Build** and select the uploaded build.
4.  **Screenshots:** Upload screenshots for required device sizes (6.5" and 5.5" displays).
5.  **Review Information:** Provide a demo account if your app requires login. Add notes for the reviewer if needed.
6.  Click **Add for Review**.
7.  Click **Submit to App Review**.

## 8. Review Process

*   **Waiting for Review:** Usually takes 24-48 hours.
*   **In Review:** Reviewer is testing your app.
*   **Accepted:** Your app is ready for sale! You can release manually or automatically.
*   **Rejected:** Read the resolution center message, fix the issue, and resubmit. Common reasons: crashes, broken links, incomplete information, guideline violations.

## Checklist

- [ ] Enroll in Apple Developer Program.
- [ ] Create App ID in Developer Portal.
- [ ] Create App in App Store Connect.
- [ ] Configure `PrivacyInfo.xcprivacy` in Xcode.
- [ ] Update Version and Build Number in `pubspec.yaml` (Flutter handles this).
- [ ] Archive and Upload build via Xcode.
- [ ] Test using TestFlight.
- [ ] Fill out all App Store Connect metadata (Privacy, Pricing, etc.).
- [ ] Upload Screenshots.
- [ ] Submit for Review.
