# GitHub Actions Guide for Flutter

**Source:** [Flutter in Production - Module 12](https://pro.codewithandrea.com/flutter-in-production/12-github-actions/01-intro)

This guide covers how to automate your Flutter build and release process using GitHub Actions.

## 1. Basics

*   **Workflow:** A configurable automated process defined by a YAML file in `.github/workflows/`.
*   **Event:** Triggers a workflow (e.g., `push`, `pull_request`, `workflow_dispatch`).
*   **Job:** A set of steps that execute on the same runner.
*   **Step:** An individual task (e.g., run a script, use an action).
*   **Runner:** A server that runs your workflow (e.g., `ubuntu-latest`, `macos-latest`).

## 2. Basic Workflow Example

Create `.github/workflows/flutter_build.yml`:

```yaml
name: Flutter Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
```

## 3. Secrets and Environment Variables

Never commit sensitive data (API keys, keystores) to your repo. Use GitHub Secrets.

1.  Go to **Settings** > **Secrets and variables** > **Actions**.
2.  Add secrets like `ANDROID_KEYSTORE_BASE64`, `KEY_PASSWORD`, `STORE_PASSWORD`, `PLAY_STORE_JSON`.
3.  Access in YAML: `${{ secrets.MY_SECRET }}`.

## 4. Android Release Workflow

To build and release an Android App Bundle:

1.  **Encode Keystore:**
    Convert your `.jks` file to Base64:
    ```bash
    openssl base64 < upload-keystore.jks | tr -d '\n' | pbcopy
    ```
    Save this as a secret `ANDROID_KEYSTORE_BASE64`.

2.  **Decode in Workflow:**
    ```yaml
    - name: Decode Keystore
      run: |
        echo "${{ secrets.ANDROID_KEYSTORE_BASE64 }}" | base64 --decode > android/upload-keystore.jks
    ```

3.  **Create `key.properties`:**
    ```yaml
    - name: Create key.properties
      run: |
        echo "storePassword=${{ secrets.STORE_PASSWORD }}" > android/key.properties
        echo "keyPassword=${{ secrets.KEY_PASSWORD }}" >> android/key.properties
        echo "keyAlias=upload" >> android/key.properties
        echo "storeFile=../upload-keystore.jks" >> android/key.properties
    ```

4.  **Build:**
    ```yaml
    - run: flutter build appbundle --release
    ```

5.  **Upload to Play Store:**
    Use `r0adkll/upload-google-play@v1`. You need a Service Account JSON key from Google Cloud Console (linked to Play Console).

## 5. iOS Release Workflow

Requires a macOS runner (more expensive/limited minutes on free tier).

1.  **Certificates & Profiles:**
    Export your distribution certificate (`.p12`) and provisioning profile (`.mobileprovision`).
    Encode them to Base64 and store as secrets.

2.  **Import in Workflow:**
    Use `Apple-Actions/import-codesign-certs` (or similar steps) to install the keychain and profile on the runner.

3.  **Build:**
    ```yaml
    - run: flutter build ipa --release --export-options-plist=ios/Runner/ExportOptions.plist
    ```

4.  **Upload to App Store:**
    Use `Apple-Actions/upload-testflight-build` or `xcrun altool`. Requires App Store Connect API Key.

## 6. Reusable Workflows

To avoid duplication, create reusable workflows (e.g., `build-android.yml`, `build-ios.yml`) and call them from a main `release.yml`.

```yaml
# release.yml
jobs:
  android:
    uses: ./.github/workflows/build-android.yml
    secrets: inherit
  ios:
    uses: ./.github/workflows/build-ios.yml
    secrets: inherit
```

## 7. Checklist

- [ ] Create `.github/workflows` directory.
- [ ] Define `on` triggers (push to main, tags, manual dispatch).
- [ ] Add `flutter-action` to setup Flutter.
- [ ] Add `flutter analyze` and `flutter test`.
- [ ] Generate Base64 strings for Keystores and Certificates.
- [ ] Add Secrets to GitHub Repository.
- [ ] Implement Keystore decoding steps.
- [ ] Implement `flutter build appbundle` (Android).
- [ ] Implement `flutter build ipa` (iOS).
- [ ] Configure Upload actions (Play Store / TestFlight).
- [ ] Test workflow with a manual run.
