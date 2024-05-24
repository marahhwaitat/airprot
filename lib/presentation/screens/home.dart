import 'package:airport/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../data/repos/passenger_local.dart';
import 'details/passenger_details.dart';
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset('assets/images/logo.jpeg', width: size.width, fit: BoxFit.cover,)
              ),
            ),
            SizedBox(height: size.height * 0.1),

            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                width: size.width,
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/passenger.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 1),
                  onPressed: () {
                    String? ret = PassengerLocal.getPassportNum();
                    ret == null || ret == ''?
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const PassengerLogin(),
                    )):
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PassengerDetails(passportNum: ret,),
                    ));
                  } ,
                  child: Text('Passenger',style: context.getThemeTextStyle().titleLarge),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                width: size.width,
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/airline.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const AdminLogin(airport: false),
                  )),
                  child: Text('Airline',style: context.getThemeTextStyle().titleLarge),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                width: size.width,
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/airport.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 1),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const AdminLogin(airport: true),
                      )),
                  child: Text('Airport',style: context.getThemeTextStyle().titleLarge),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}