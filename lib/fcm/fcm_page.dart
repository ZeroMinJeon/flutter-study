import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';

class FCM_Page extends StatelessWidget {
  const FCM_Page({Key? key}) : super(key: key);

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      Get.to(SelectPayloadScreen(data: payload));
    }
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    Get.to(OnDidPayloadScreen(title: title, body: body, payload: payload,));
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
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Get.to(SelectPayloadScreen(title: 'onMessage +${message.notification?.title ?? ''}',data: message.notification?.body ?? ''));
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    Get.to(SelectPayloadScreen(data: message.data.toString()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("FCM Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'FCM',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1,
            ),
            TextButton(onPressed: checkFirebaseSetting, child: Text("setting")),
          ],
        ),)
      ,
    );
  }
}

class SelectPayloadScreen extends StatelessWidget {
  const SelectPayloadScreen({Key? key,this.title = '' , required this.data})
      : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          data,
          style: Theme
              .of(context)
              .textTheme
              .headline1,
        ),
      ),
    );
  }
}

class OnDidPayloadScreen extends StatelessWidget {
  const OnDidPayloadScreen({Key? key, this.title, this.body, this.payload})
      : super(key: key);

  final String? title;
  final String? body;
  final String? payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
      ),
      body: Center(
        child: Column(
          children: [
            Text(body ?? '', style: Theme
                .of(context)
                .textTheme
                .headline1,),
            Text(payload ?? '', style: Theme
                .of(context)
                .textTheme
                .headline3,)
          ],
        ),
      ),
    );
  }
}
