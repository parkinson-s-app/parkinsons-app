import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  static AndroidNotificationDetails androidSettings;
  static IOSNotificationDetails iosSettings;

  static Initializer() {
    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
    androidSettings = AndroidNotificationDetails(
        "111", "Solicitud de relación", "Tienes una solicitud de relación",
        importance: Importance.High, priority: Priority.Max);
    iosSettings = IOSNotificationDetails();
    var platform = NotificationDetails(androidSettings, iosSettings);
    var androidInitialization = AndroidInitializationSettings('app_icon');
    var initializationSettings =
    InitializationSettings(androidInitialization, null);
    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onNotificationSelect);
  }

  static Future<void> onNotificationSelect(String payload) async {
    print(payload);
  }

  static ShowOneTimeNotification(DateTime scheduledDate) async {
    var notificationDetails = NotificationDetails(androidSettings, null);
    await flutterNotificationPlugin.schedule(1, "Background Task notification",
        "backgroud task notification", scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }
}