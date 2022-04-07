import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('main_channel', 'Main Channel',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@drawable/ic_flutternotification'),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android =
        AndroidInitializationSettings('@drawable/ic_flutternotification');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
    if (initScheduled) {
      tz.initializeTimeZones();
      final String locationName =
          await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

 

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );
  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
    required DateTime scheduledDate,
  }) async {
    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      // _scheduledDaily(const Time(4)),
      await _notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      
    );
  }

  static tz.TZDateTime _scheduledDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}



// class NotificationService {
//   static final NotificationService _notificationService = NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   NotificationService._internal();

//   Future<void> initNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@drawable/ic_flutternotification');

//     const IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification(int id, String title, String body, int seconds) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'main_channel',
//           'Main Channel',
          
//           importance: Importance.max,
//           priority: Priority.max,
//           icon: '@drawable/ic_flutternotification'
//         ),
//         iOS: IOSNotificationDetails(
//           sound: 'default.wav',
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }