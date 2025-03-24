import 'dart:developer';

import 'package:fcm_flutter_notification/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  // Create an instance of FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notifications
  Future<void> initNotifications() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // fetch FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();

    // print token to console
    log('FCM Token: $fcmToken');

    initPushNotifications();
  }

  // function to handle received messages
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState!.pushNamed(
      '/notification-screen',
      arguments: message,
    );
    log('Message data: $message');
  }

  // function to initialize background settings
  Future<void> initPushNotifications() async {
    // handle notification  if the app was termined  nd now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach even listener for where notification open the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
