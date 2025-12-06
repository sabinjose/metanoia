# Android App Release Guide

**Source:** [Flutter in Production - Module 10](https://pro.codewithandrea.com/flutter-in-production/10-release-android/01-intro)

This guide covers the end-to-end process of releasing a Flutter app to the Google Play Store, from creating a developer account to submitting for review.

## 1. Google Play Console Account

*   **Requirement:** You must have a [Google Play Console](https://play.google.com/console) account ($25 one-time fee).
*   **Account Types:**
    *   **Personal:** For individual developers.
    *   **Organization:** For businesses. Requires a D-U-N-S number.
*   **Verification:** Google now requires identity verification for all accounts.

## 2. Create App in Play Console

1.  Go to **Google Play Console** > **All apps**.
2.  Click **Create app**.
3.  **App Name:** Public name of your app.
4.  **Default Language:** e.g., English (United States).
5.  **App or Game:** Select **App**.
6.  **Free or Paid:** Select **Free** (cannot change from Free to Paid later).
7.  **Declarations:** Accept Developer Program Policies and US Export Laws.
8.  Click **Create app**.

## 3. App Content & Data Safety

You must complete the **App Content** section before you can release.

*   **Privacy Policy:** Link to your privacy policy URL (see [App Landing Page Guide](./app_landing_page.md)).
*   **Ads:** Declare if your app contains ads.
*   **App Access:** Provide credentials if your app requires login.
*   **News Apps:** Declare if you are a news app.
*   **COVID-19:** Declare status.
*   **Data Safety:**
    *   Crucial section. You must disclose what data you collect and share.
    *   **Collection:** e.g., Name, Email, Photos.
    *   **Sharing:** Do you share data with third parties?
    *   **Security:** Is data encrypted in transit? Can users request deletion?
*   **Government Apps:** Declare status.
*   **Financial Features:** Declare status.

## 4. Store Listing

Configure how your app appears in the Play Store.

*   **Main Store Listing:**
    *   **App Name:** 30 chars max.
    *   **Short Description:** 80 chars max.
    *   **Full Description:** 4000 chars max.
    *   **Graphics:**
        *   **App Icon:** 512x512 PNG.
        *   **Feature Graphic:** 1024x500 PNG/JPEG.
        *   **Phone Screenshots:** At least 2.
        *   **Tablet Screenshots:** If you support tablets.

## 5. Android Configuration (Flutter)

Ensure your `android/app/build.gradle` and `pubspec.yaml` are correct.

*   **Package Name:** Must be unique (e.g., `com.example.confessionapp`).
*   **Version:**
    *   `versionCode`: Integer, must increment with every release.
    *   `versionName`: String, visible to users (e.g., "1.0.0").
    *   Flutter handles this via `pubspec.yaml`: `version: 1.0.0+1`.

## 6. Code Signing & Keystore

You need a keystore to sign your app release bundle.

1.  **Create Keystore:**
    ```bash
    keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```
    *   Keep this file safe! If you lose it, you can't update your app (though Play App Signing helps).
2.  **Configure `key.properties`:**
    Create `android/key.properties`:
    ```properties
    storePassword=<password>
    keyPassword=<password>
    keyAlias=upload
    storeFile=../upload-keystore.jks
    ```
3.  **Update `build.gradle`:**
    Configure the `release` build type to use this signing config.

## 7. Building App Bundle

Google Play requires Android App Bundles (`.aab`) instead of APKs.

1.  Run:
    ```bash
    flutter build appbundle
    ```
2.  Output: `build/app/outputs/bundle/release/app-release.aab`.

## 8. Testing Tracks

Google Play has multiple tracks for testing:

*   **Internal Testing:** Fast, for your team. Up to 100 testers. No review required.
*   **Closed Testing:** For a wider group. Requires review.
*   **Open Testing:** Anyone can join. Requires review.
*   **Production:** The live app.

**Requirement:** For personal accounts created after Nov 2023, you **must** run a Closed Test with at least 20 testers for 14 days before you can apply for Production access.

## 9. Releasing to Production

1.  Go to **Production** track.
2.  **Create new release**.
3.  Upload your `.aab` file.
4.  **Release Name:** e.g., "1.0.0".
5.  **Release Notes:** What's new in this version.
6.  **Next** > **Start rollout to Production**.

## 10. Review Process

*   **Review Times:** Can take up to 7 days (longer for new accounts).
*   **Updates:** Usually faster (hours to a day).
*   **Managed Publishing:** Turn this on to control exactly when the update goes live after approval.

## Checklist

- [ ] Create Google Play Console account.
- [ ] Verify identity.
- [ ] Create App in Console.
- [ ] Complete App Content (Privacy, Data Safety, etc.).
- [ ] Create Store Listing (Icon, Screenshots, Description).
- [ ] Generate Upload Keystore.
- [ ] Configure Signing in `build.gradle`.
- [ ] Build App Bundle (`flutter build appbundle`).
- [ ] Upload to Internal/Closed Testing.
- [ ] (New Accounts) Run Closed Test with 20 testers for 14 days.
- [ ] Apply for Production Access.
- [ ] Release to Production.
