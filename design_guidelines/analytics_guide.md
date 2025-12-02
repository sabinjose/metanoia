# App Analytics Guide (Mixpanel & Firebase)

**Source:** [Flutter in Production - Module 5](https://pro.codewithandrea.com/flutter-in-production/05-analytics/01-intro)

This guide covers implementing analytics to track user behavior, using a robust architecture that supports multiple providers (Mixpanel, Firebase).

## 1. Concepts

*   **Events:** Actions users take (e.g., `login_success`, `item_purchased`, `screen_view`).
*   **Properties:** Metadata attached to events (e.g., `item_id`, `price`, `screen_name`).
*   **User Identification:** Tying events to a specific user ID (once logged in) to track journeys across devices.

## 2. Tool Comparison

*   **Firebase Analytics:**
    *   **Pros:** Free, unlimited events, integrates with other Firebase tools (Crashlytics, A/B Testing, Remote Config).
    *   **Cons:** Harder to debug (events take time to show), less granular funnel analysis than Mixpanel.
*   **Mixpanel:**
    *   **Pros:** Real-time updates, powerful funnels and retention analysis, great for product insights.
    *   **Cons:** Paid (with a generous free tier), event limits.

**Strategy:** Use **both**. Firebase for general "health" and Google ecosystem integration. Mixpanel for deep product usage analysis.

## 3. Architecture

Do not call SDKs directly in your widgets. Create an abstraction layer.

### 3.1. Abstract Client

```dart
abstract class AnalyticsClient {
  Future<void> trackScreenView(String routeName, {String? action});
  Future<void> trackEvent(String eventName, {Map<String, dynamic>? properties});
  Future<void> setUserId(String? userId);
  Future<void> setUserProperties(Map<String, dynamic> properties);
}
```

### 3.2. Repository/Service

Create an `AnalyticsService` that holds a list of clients and delegates calls to all of them.

```dart
class AnalyticsService {
  final List<AnalyticsClient> _clients;

  AnalyticsService(this._clients);

  Future<void> trackEvent(String eventName, {Map<String, dynamic>? properties}) async {
    for (final client in _clients) {
      await client.trackEvent(eventName, properties: properties);
    }
  }
  // ... implement other methods
}
```

## 4. Implementation Details

### 4.1. Mixpanel Setup

1.  Add `mixpanel_flutter`.
2.  Initialize:
    ```dart
    class MixpanelAnalyticsClient implements AnalyticsClient {
      final Mixpanel _mixpanel;
      MixpanelAnalyticsClient(this._mixpanel);

      // Implement methods using _mixpanel.track(), _mixpanel.identify(), etc.
    }
    ```

### 4.2. Firebase Setup

1.  Add `firebase_analytics`.
2.  Initialize:
    ```dart
    class FirebaseAnalyticsClient implements AnalyticsClient {
      final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

      // Implement methods using _analytics.logEvent(), _analytics.setUserId(), etc.
    }
    ```

### 4.3. Tracking Navigation

Use a `NavigatorObserver` (or `GoRouter` listener) to track screen views automatically.

```dart
class AnalyticsNavigationObserver extends NavigatorObserver {
  final AnalyticsService analytics;
  AnalyticsNavigationObserver(this.analytics);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final name = route.settings.name;
    if (name != null) {
      analytics.trackScreenView(name);
    }
  }
}
```

## 5. User Consent (GDPR/Privacy)

**Crucial:** You must allow users to opt-out of analytics.

1.  Add a "Usage Statistics" toggle in your App Settings.
2.  Store the preference locally (e.g., `SharedPreferences`).
3.  Initialize your `AnalyticsService` with this preference.
4.  If disabled, do not initialize the clients or stop sending events.

## 6. Checklist

- [ ] Define `AnalyticsClient` interface.
- [ ] Implement `MixpanelAnalyticsClient`.
- [ ] Implement `FirebaseAnalyticsClient`.
- [ ] Create `AnalyticsService` to manage multiple clients.
- [ ] Implement `AnalyticsNavigationObserver` for screen tracking.
- [ ] Add "Opt-out" setting for users.
- [ ] Verify events are appearing in Mixpanel Live View and Firebase DebugView.
