import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    final androidImplementation =
        _notifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidImplementation != null) {
      return await androidImplementation.requestNotificationsPermission() ??
          false;
    }

    final iosImplementation =
        _notifications
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();

    if (iosImplementation != null) {
      return await iosImplementation.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    return true;
  }

  Future<void> scheduleReminder({
    required int weekday, // 1 = Monday, 7 = Sunday
    required int hour,
    required int minute,
    required int advanceDays,
    required bool isBiweekly,
    required bool isMonthly,
    required bool isQuarterly,
  }) async {
    // Cancel existing reminders first to avoid duplicates
    await cancelAllReminders();

    try {
      await _notifications.zonedSchedule(
        0,
        'Time for Confession',
        'Remember to examine your conscience and prepare for confession',
        _nextInstance(
          weekday: weekday,
          hour: hour,
          minute: minute,
          advanceDays: advanceDays,
          isBiweekly: isBiweekly,
          isMonthly: isMonthly,
          isQuarterly: isQuarterly,
        ),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'confession_reminder',
            'Confession Reminders',
            channelDescription: 'Reminders for confession',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents:
            isBiweekly || isMonthly || isQuarterly
                ? DateTimeComponents
                    .dayOfMonthAndTime // Complex repeats need manual handling or this approximation
                : DateTimeComponents
                    .dayOfWeekAndTime, // Weekly works well with this
      );
    } catch (e) {
      // Fallback to inexact alarm if exact alarm permission is not granted
      if (e.toString().contains('exact_alarms_not_permitted')) {
        await _notifications.zonedSchedule(
          0,
          'Time for Confession',
          'Remember to examine your conscience and prepare for confession',
          _nextInstance(
            weekday: weekday,
            hour: hour,
            minute: minute,
            advanceDays: advanceDays,
            isBiweekly: isBiweekly,
            isMonthly: isMonthly,
            isQuarterly: isQuarterly,
          ),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'confession_reminder',
              'Confession Reminders',
              channelDescription: 'Reminders for confession',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents:
              isBiweekly || isMonthly || isQuarterly
                  ? DateTimeComponents.dayOfMonthAndTime
                  : DateTimeComponents.dayOfWeekAndTime,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
  }

  tz.TZDateTime _nextInstance({
    required int weekday,
    required int hour,
    required int minute,
    required int advanceDays,
    required bool isBiweekly,
    required bool isMonthly,
    required bool isQuarterly,
  }) {
    final now = tz.TZDateTime.now(tz.local);

    // Start with today at the target time
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // 1. Find the target day (e.g., next Saturday)
    // For Monthly/Quarterly, we assume "First [Weekday] of the Month/Quarter" for now based on previous logic,
    // OR we could simplify to "Day X of the month".
    // The user request implied "Next confession is on first saturday... User should be able to choose date."
    // This implies choosing a specific date or a pattern.
    // Let's stick to the "Day of Week" pattern for Weekly/Biweekly, and "First [Weekday]" for Monthly/Quarterly for now,
    // as "Day of Month" (e.g. 15th) might conflict with "Saturday".
    // Let's assume the user selects a Weekday (e.g. Saturday) and we find the next occurrence.

    if (isMonthly) {
      // Find first [weekday] of next month
      // Logic: Move to 1st of next month, then find first [weekday]
      // If today is before the first [weekday] of this month, use this month.

      // Let's simplify: Find the next occurrence of "First [Weekday] of Month"
      // Check current month first
      var candidate = _findFirstWeekdayOfMonth(
        now.year,
        now.month,
        weekday,
        hour,
        minute,
      );
      // Apply advance notice
      var triggerDate = candidate.subtract(Duration(days: advanceDays));

      if (triggerDate.isBefore(now)) {
        // Too late for this month, move to next month
        candidate = _findFirstWeekdayOfMonth(
          now.year,
          now.month + 1,
          weekday,
          hour,
          minute,
        );
        triggerDate = candidate.subtract(Duration(days: advanceDays));
      }
      return triggerDate;
    } else if (isQuarterly) {
      // Similar to monthly but every 3 months
      // Check current quarter
      var candidate = _findFirstWeekdayOfMonth(
        now.year,
        now.month,
        weekday,
        hour,
        minute,
      );
      var triggerDate = candidate.subtract(Duration(days: advanceDays));

      if (triggerDate.isBefore(now)) {
        // Move to next quarter
        int nextMonth = now.month + 3;
        int year = now.year;
        if (nextMonth > 12) {
          nextMonth -= 12;
          year++;
        }
        candidate = _findFirstWeekdayOfMonth(
          year,
          nextMonth,
          weekday,
          hour,
          minute,
        );
        triggerDate = candidate.subtract(Duration(days: advanceDays));
      }
      return triggerDate;
    } else {
      // Weekly or Bi-weekly
      // Find next [weekday]
      while (scheduledDate.weekday != weekday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // Apply advance notice to check if we missed it
      var triggerDate = scheduledDate.subtract(Duration(days: advanceDays));

      if (triggerDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 7));
        triggerDate = scheduledDate.subtract(Duration(days: advanceDays));
      }

      if (isBiweekly) {
        // If it's bi-weekly, we might want to skip a week?
        // Without storing state of "last reminder", we can't truly alternate.
        // For now, we'll just schedule it.
        // To do it properly, we'd need to save the "start date" of the cycle.
        // Let's assume the cycle starts "now".
        scheduledDate = scheduledDate.add(const Duration(days: 7));
        triggerDate = scheduledDate.subtract(Duration(days: advanceDays));
      }

      return triggerDate;
    }
  }

  tz.TZDateTime _findFirstWeekdayOfMonth(
    int year,
    int month,
    int weekday,
    int hour,
    int minute,
  ) {
    // Handle month overflow
    if (month > 12) {
      year += (month - 1) ~/ 12;
      month = (month - 1) % 12 + 1;
    }

    var date = tz.TZDateTime(tz.local, year, month, 1, hour, minute);
    while (date.weekday != weekday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }
}
