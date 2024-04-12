import 'package:flutter/material.dart';

import 'screens/login_screen.dart'; // Import LoginScreen
import 'screens/admin_login_screen.dart'; // Import AdminLoginScreen

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',

    );
  }
}
