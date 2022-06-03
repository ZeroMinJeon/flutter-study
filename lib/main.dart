import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter3study/bluetooth/bluetooth_screen.dart';
import 'package:flutter3study/drag_tag/drag_tag_screen.dart';
import 'package:flutter3study/fcm/fcm_page.dart';
import 'package:flutter3study/graph/graph_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  // FirebaseMessaging.onMessage.listen(_handleMessage);
}

void selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
    Get.to(SelectPayloadScreen(data: payload));
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  Get.to(OnDidPayloadScreen(
    title: title,
    body: body,
    payload: payload,
  ));
}

void checkFirebaseSetting() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await messaging.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  await messaging.setAutoInitEnabled(true);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  FirebaseMessaging.onMessage.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  Get.to(SelectPayloadScreen(
      title: 'onMessage +${message.notification?.title ?? ''}',
      data: message.notification?.body ?? ''));
}

void _handleMessageOpenedApp(RemoteMessage message) {
  Get.to(SelectPayloadScreen(
      title: 'opened +${message.notification?.title ?? ''}',
      data: message.notification?.body ?? ''));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  checkFirebaseSetting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(title: 'HOME'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          ElevatedButton(
              onPressed: () => Get.to(() => FCM_Page()),
              child: Text(('FCM').toString())),
          ElevatedButton(
              onPressed: () => Get.to(() => const GraphScreen()),
              child: Text(('GRAPH').toString())),
          ElevatedButton(
              onPressed: () => Get.to(() => const BluetoothScreen()),
              child: Text(('BT').toString())),
          ElevatedButton(
              onPressed: () => Get.to(() => DragTagScreen()),
              child: Text(('DRAG').toString())),
        ],
      ),
    );
  }
}
