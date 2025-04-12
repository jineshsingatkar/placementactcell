import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );

      const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
          print('Notification tapped: ${details.payload}');
        },
      );

      // Initialize timezone
      tz.initializeTimeZones();
      _isInitialized = true;
      print('NotificationService initialized successfully');
    } catch (e) {
      print('Error initializing NotificationService: $e');
      _isInitialized = false;
      rethrow;
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      if (!_isInitialized) {
        throw Exception('NotificationService not initialized');
      }

      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: const AndroidNotificationDetails(
            'placement_notifications',
            'Placement Notifications',
            channelDescription: 'Notifications for placement updates',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: payload,
      );
      print('Notification shown successfully: ID=$id, Title=$title');
    } catch (e) {
      print('Error showing notification: $e');
      rethrow;
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    try {
      if (!_isInitialized) {
        throw Exception('NotificationService not initialized');
      }

      if (scheduledDate.isBefore(DateTime.now())) {
        throw Exception('Scheduled date must be in the future');
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        NotificationDetails(
          android: const AndroidNotificationDetails(
            'placement_notifications',
            'Placement Notifications',
            channelDescription: 'Notifications for placement updates',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
      print('Notification scheduled successfully: ID=$id, Title=$title, Date=$scheduledDate');
    } catch (e) {
      print('Error scheduling notification: $e');
      rethrow;
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      if (!_isInitialized) {
        throw Exception('NotificationService not initialized');
      }

      await flutterLocalNotificationsPlugin.cancel(id);
      print('Notification cancelled successfully: ID=$id');
    } catch (e) {
      print('Error cancelling notification: $e');
      rethrow;
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      if (!_isInitialized) {
        throw Exception('NotificationService not initialized');
      }

      await flutterLocalNotificationsPlugin.cancelAll();
      print('All notifications cancelled successfully');
    } catch (e) {
      print('Error cancelling all notifications: $e');
      rethrow;
    }
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      if (!_isInitialized) {
        throw Exception('NotificationService not initialized');
      }

      final List<PendingNotificationRequest> pendingNotifications =
          await flutterLocalNotificationsPlugin.pendingNotificationRequests();
      print('Retrieved ${pendingNotifications.length} pending notifications');
      return pendingNotifications;
    } catch (e) {
      print('Error getting pending notifications: $e');
      rethrow;
    }
  }
}
