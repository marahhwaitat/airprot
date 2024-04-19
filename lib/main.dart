import 'package:airprot/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'core/utilities/themes.dart';
import 'screens/login_screen.dart'; // Import LoginScreen
import 'screens/admin_login_screen.dart'; // Import AdminLoginScreen

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Treasure Hunt',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
