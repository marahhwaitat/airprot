import 'package:airport/core/global/global.dart';
import 'package:airport/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/flight/flight_bloc.dart';
import '../../bloc/passenger/passenger_bloc.dart';
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

            SizedBox(
              width: size.width,
              height: size.height * 0.08,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const PassengerLogin(),
                    )),
                child:  Text('Passenger',style: context.getThemeTextStyle().titleLarge),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              width: size.width,
              height: size.height * 0.08,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const AdminLogin(airport: false),
                )),
                child:  Text('Airline',style: context.getThemeTextStyle().titleLarge),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              width: size.width,
              height: size.height * 0.08,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const AdminLogin(airport: true),
                    )),
                child:  Text('Airport',style: context.getThemeTextStyle().titleLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}