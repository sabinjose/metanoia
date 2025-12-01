# Automated Screenshot Generation Guide

**Source:** [Flutter in Production - Module 14](https://pro.codewithandrea.com/flutter-in-production/14-screenshots/01-intro)

This guide covers strategies and tools for automating the creation of app store screenshots, a critical part of your app's marketing.

## 1. Why Automate?

*   **Consistency:** Ensure screenshots look the same across all devices and languages.
*   **Efficiency:** Manually taking screenshots for multiple devices (Phone, Tablet) and languages is tedious and error-prone.
*   **Maintenance:** Easily update screenshots when your UI changes.

## 2. Strategy: Manual vs. Automated

*   **Manual:**
    *   Good for: Simple apps, single language, few device sizes.
    *   Tools: Simulator/Emulator screenshots, then frame in Figma/Canva.
*   **Automated:**
    *   Good for: Complex apps, multiple languages, frequent updates.
    *   Tools: Integration tests (Maestro/Flutter Integration Test) + Fastlane.

## 3. Tools Overview

### Maestro
*   **Purpose:** UI Testing and Screenshot Capture.
*   **Pros:** Simple YAML syntax, resilient to flakiness, cross-platform.
*   **Workflow:** Write a flow that navigates your app and takes screenshots at key moments.

### Fastlane
*   **Purpose:** Automation of build, release, and screenshot management.
*   **Key Tools:**
    *   `snapshot` (iOS): Uses UI Tests to capture screenshots.
    *   `screengrab` (Android): Uses Espresso/UiAutomator.
    *   `deliver` (iOS) & `supply` (Android): Uploads screenshots and metadata to stores.

## 4. Implementation Steps

### Step 1: Design & Planning
*   **Checklist:** Define which screens to capture (Home, Details, Settings, etc.).
*   **Narrative:** Ensure screenshots tell a story.
*   **Framing:** Decide if you want raw screenshots or framed ones (with device bezel and caption).

### Step 2: Capture with Maestro (Recommended)
1.  Install Maestro.
2.  Create a flow `screenshots.yaml`:
    ```yaml
    appId: com.example.app
    ---
    - launchApp
    - takeScreenshot: landing_page
    - tapOn: "Get Started"
    - takeScreenshot: home_page
    ```
3.  Run flow to generate screenshots.

### Step 3: Frame & Edit
*   **Figma:** Import raw screenshots and use a template to add device frames and marketing text.
*   **Fastlane Frameit:** Automate framing (iOS only, advanced).

### Step 4: Automate Uploads with Fastlane

#### iOS Setup (`fastlane/Fastfile`)
```ruby
lane :screenshots do
  capture_ios_screenshots(
    scheme: "Runner",
    devices: ["iPhone 14 Pro Max", "iPad Pro (12.9-inch) (6th generation)"],
    languages: ["en-US"]
  )
  upload_to_app_store(skip_binary_upload: true)
end
```

#### Android Setup (`fastlane/Fastfile`)
```ruby
lane :screenshots do
  capture_android_screenshots(
    device_type: "pixel6",
    locales: ["en-US"]
  )
  upload_to_play_store(skip_upload_apk: true)
end
```

### Step 5: CI/CD Integration
*   Add a step in your GitHub Actions workflow to run Fastlane.
*   Trigger on specific branches or tags to auto-update store listings.

## 5. Checklist

- [ ] Define list of screenshots to capture.
- [ ] Choose tool: Manual, Maestro, or Flutter Integration Test.
- [ ] Create automation scripts/flows.
- [ ] Set up Fastlane for iOS (`snapshot` + `deliver`).
- [ ] Set up Fastlane for Android (`screengrab` + `supply`).
- [ ] Design frame templates (Figma or Frameit).
- [ ] Verify screenshots look good on all target devices.
- [ ] Automate upload process via GitHub Actions.
