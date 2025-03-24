import 'package:fcm_flutter_notification/firebase_options.dart';
import 'package:fcm_flutter_notification/pages/home_page.dart';
import 'package:fcm_flutter_notification/pages/notification_page.dart';
import 'package:fcm_flutter_notification/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FCM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification-screen': (context) => const NotificationPage(),
      },
    );
  }
}
