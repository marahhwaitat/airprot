import 'package:airprot/core/utilities/utilities.dart';
import 'package:airprot/presentation/screens/flight_info_screen.dart';
import 'package:flutter/material.dart';


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
              height: size.height * 0.28,
              child: Image.asset('assets/images/logo.png',
                width: size.width, fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: size.height * 0.1),

            _difficultyButton(size, 0, 'Add Flight', Colors.green),
            SizedBox(height: size.height * 0.01),
            _difficultyButton(size, 1, 'Add Airline', Theme.of(context).canvasColor),
            SizedBox(height: size.height * 0.01),
            _difficultyButton(size, 2, 'Add Passenger', Theme.of(context).primaryColor),
            SizedBox(height: size.height * 0.01),
            _difficultyButton(size, 2, 'Edit Flight', Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  _navigate() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const FlightInfoScreen(),
        ));

  Widget _difficultyButton(Size size, int dif, String text, Color color) => SizedBox(
    width: size.width,
    height: size.height * 0.08,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: () => _navigate(),
      child:  Text(text,style: context.getThemeTextStyle().titleLarge),
    ),
  );

}