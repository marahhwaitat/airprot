import 'package:flutter/material.dart';
import 'package:first_app1/screens/flight_info_screen.dart'; // استيراد شاشة معلومات الرحلة

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // ابناء الـ Column
    var column2 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('image/airport.png'),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Sign In',
          style: TextStyle(
            fontFamily: 'mar',
            fontSize: 38,
            color: Colors.blue[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Passport Number',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              // استدعاء Navigator عند الضغط على زر sign in
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlightInfoScreen()),
                );
              },
              child: Center(
                child: Text(
                  'sign in',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    var column = column2;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: column,
        ),
      ),
    );
  }
}
