import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:new_flutter_project/screens/CalendarScreen.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      print("Notification tapped: ${response.payload}");
    },
  );

  tzdata.initializeTimeZones();
}

void scheduleLocalNotification(
    String title, String body, DateTime scheduledTime) async {
  const androidDetails = AndroidNotificationDetails(
    'exam_reminders',
    'Exam Reminders',
    importance: Importance.max,
    priority: Priority.high,
  );

  var platformDetails = const NotificationDetails(android: androidDetails);

  tz.TZDateTime adjustedTime = tz.TZDateTime.from(scheduledTime, tz.local).subtract(const Duration(hours: 24));

  await flutterLocalNotificationsPlugin.zonedSchedule(
    DateTime.now().millisecondsSinceEpoch.remainder(100000),
    title,
    body,
    adjustedTime,
    platformDetails,
    androidScheduleMode: AndroidScheduleMode.exact,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _initializeLocalNotifications();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not granted permission');
  }

  String? token = await messaging.getToken();
  print("FCM Token: $token");

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print("New FCM Token: $newToken");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a message: ${message.notification?.title}');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      scheduleLocalNotification(
        message.notification!.title ?? "Notification",
        message.notification!.body ?? "You have a new message.",
        DateTime.now().add(const Duration(seconds: 5)), 
      );
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      initialRoute: '/',
      routes: {
        '/': (context) => CalendarScreen(),
      },
    );
  }
}
