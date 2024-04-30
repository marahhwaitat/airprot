import 'package:airprot/core/utils/utilities.dart';
import 'package:flutter/material.dart';

import 'login/passenger_login.dart';
import 'login/admin_login.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05),
            SizedBox(
              height: size.height * 0.3,
              child: Image.asset('assets/images/logo.png',
                width: size.width, fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: size.height * 0.1),

            _difficultyButton(size, 0, 'Passenger', Colors.green),
            SizedBox(height: size.height * 0.01),
            _difficultyButton(size, 1, 'Airline', Theme.of(context).canvasColor),
            SizedBox(height: size.height * 0.01),
            _difficultyButton(size, 2, 'Airport', Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  _navigate(int user) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => user == 0? const PassengerLogin()
      : user == 1? const AdminLogin(airport: false) : const AdminLogin(airport: true),
    ));
  }

  Widget _difficultyButton(Size size, int user, String text, Color color) => SizedBox(
    width: size.width,
    height: size.height * 0.08,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: () => _navigate(user),
      child:  Text(text,style: context.getThemeTextStyle().titleLarge),
    ),
  );

}