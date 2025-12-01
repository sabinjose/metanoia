# App Landing Page Implementation Guide

**Source:** [Flutter in Production - Module 8](https://pro.codewithandrea.com/flutter-in-production/08-app-landing-page/01-intro)

This guide details how to create and deploy a landing page for your app, which is crucial for App Store/Play Store requirements (support URL, marketing URL) and hosting legal documents.

## Overview

A landing page serves two main purposes:
1.  **Marketing:** A place to showcase your app's features and provide download links.
2.  **Compliance:** A host for your Privacy Policy and Terms of Use, which are required by app stores.

## Implementation Steps

### 1. Choose a Template

For a quick and professional start, use the [Automatic App Landing Page](https://github.com/dmitry-zimek/automatic-app-landing-page) Jekyll template.

*   **Features:** Responsive, easy configuration via `_config.yml`, pre-built sections for screenshots and features.
*   **Setup:** Fork the repository to your GitHub account.

### 2. Configure the Site

Edit the `_config.yml` file in your forked repository to customize the site:
*   **App Name & Description:** Update the title and meta description.
*   **Links:** Add your App Store and Play Store URLs.
*   **Socials:** Add links to your social media profiles.
*   **Images:** Replace the placeholder images in `assets/` with your app's screenshots and logo.

### 3. Legal Documents (Privacy & Terms)

You must have a Privacy Policy. Terms of Use are recommended.

*   **Generate:** Use a service like [TermsFeed](https://www.termsfeed.com/) or similar generators to create these documents.
*   **Host:** Create `privacy.md` and `terms.md` in your repository (or paste the HTML into the appropriate layout).
*   **Link:** Ensure these are accessible from the landing page footer.

### 4. Deploy with GitHub Pages

1.  Go to your repository **Settings** > **Pages**.
2.  Select the **Source** (usually `main` or `master` branch).
3.  GitHub will build and deploy your site. You'll get a URL like `https://yourusername.github.io/your-repo-name/`.
4.  (Optional) Configure a custom domain if you own one.

### 5. In-App Integration

Add links to your landing page and legal docs within your app's settings screen.

```dart
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

// Usage
_launchURL('https://yourusername.github.io/your-repo-name/privacy');
```

## Checklist

- [ ] Fork the "Automatic App Landing Page" repo.
- [ ] Customize `_config.yml` with app details.
- [ ] Generate Privacy Policy and Terms of Use.
- [ ] Add screenshots and logo.
- [ ] Enable GitHub Pages.
- [ ] Verify the live site.
- [ ] Add links to the app's Settings page.
