import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'core/utilities/themes.dart';
import 'presentation/screens/splash_screen.dart';




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
