#!/bin/bash
# Build Release Script - Encrypts assets and builds release APK/IPA
# Usage: ./scripts/build_release.sh [apk|ios|appbundle]

set -e  # Exit on error

echo "========================================"
echo "  Metanoia Release Build Script"
echo "========================================"
echo ""

# Step 1: Encrypt assets
echo "Step 1/3: Encrypting assets..."
dart run scripts/encrypt_assets.dart
echo ""

# Step 2: Generate localizations
echo "Step 2/3: Generating localizations..."
flutter gen-l10n
echo ""

# Step 3: Build release
BUILD_TYPE="${1:-apk}"
echo "Step 3/3: Building release ($BUILD_TYPE)..."

case $BUILD_TYPE in
  apk)
    flutter build apk --release
    echo ""
    echo "APK ready at: build/app/outputs/flutter-apk/app-release.apk"
    ;;
  appbundle)
    flutter build appbundle --release
    echo ""
    echo "App Bundle ready at: build/app/outputs/bundle/release/app-release.aab"
    ;;
  ios)
    flutter build ios --release
    echo ""
    echo "iOS build ready in: build/ios/iphoneos/"
    ;;
  *)
    echo "Unknown build type: $BUILD_TYPE"
    echo "Usage: ./scripts/build_release.sh [apk|ios|appbundle]"
    exit 1
    ;;
esac

echo ""
echo "========================================"
echo "  Build Complete!"
echo "========================================"
