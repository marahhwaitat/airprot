import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'core/global/global.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool isFlutterLocalNotificationsInitialized = false;

Future<void> handleBackgroundMessage(RemoteMessage message) async {
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future<void> initLocalNotification() async {
    const InitializationSettings initializationSettings =
    InitializationSettings(android: AndroidInitializationSettings("mipmap/ic_launcher"),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
      },
    );
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  initPushNotification() {
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  initNotification() async {
    notificationSettings = await _firebaseMessaging.requestPermission();
    if (notificationSettings!.authorizationStatus == AuthorizationStatus.authorized) {
      var token = await _firebaseMessaging.getToken();
      if(sharedPreferences?.getString('token') == null || sharedPreferences?.getString('token') != token) {
        sharedPreferences?.setString('token', token!);
        FirebaseFirestore.instance.collection('Tokens').add({"token": token});
      }
    }
    await setupFlutterNotifications();
    initLocalNotification();
    initPushNotification();
  }
}
