import 'package:firebase_messaging/firebase_messaging.dart';


class NotificationManager{

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> _configureFcm() async {
    // Request notification permissions
    NotificationSettings settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications');

      // Get the FCM registration token
      String? token = await _messaging.getToken();
      print('FCM registration token: $token');

      // Subscribe to a topic (optional)
      _messaging.subscribeToTopic('your_topic_name');

      // _messaging.setForegroundMessageHandler((RemoteMessage message) {
      //   // Handle notification when app is in foreground
      //   print('Foreground message: $message');
      //   // ... process data payload if needed
      // });
    } else {
      print('User declined or has not granted notification permission');
    }

    _messaging.getInitialMessage().then((value) => (RemoteMessage message) {
      print('Received message: $message');
        // Update app data based on message payload
    });

    // _messaging.onMessage.listen((RemoteMessage message) {
    //   print('Received message: $message');
    //   // Update app data based on message payload
    // });

  }
}