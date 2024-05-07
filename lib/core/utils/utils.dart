import 'package:flutter/material.dart';

import '../../data/repos/airlines_firebase.dart';
import '../../data/repos/flights_firebase.dart';
import '../../data/repos/passengers_firebase.dart';
import '../global/global.dart';

extension ContextEx on BuildContext
{
  TextTheme getThemeTextStyle()
  {
    return Theme.of(this).textTheme;
  }
}

bool existingPassenger(String passportNum) {
  for (var passenger in myPassengers) {
    debugPrint('passportNum: ${passenger.passportNum}');
    debugPrint('passportNum: ${passenger.passportNum == passportNum}');
    if(passenger.passportNum == passportNum) return true;
  }
  return false;
}

Future<void> fetchPassengersEvent() async {
  myPassengers = await PassengersFirebaseManger.getPassengers();
  debugPrint('myPassengers: $myPassengers');
}

Future<void> fetchFlightsEvent() async {
  debugPrint('before myAirlines: $myAirlines');
  myAirlines = await AirlinesFirebaseManger.getAirlines();
  debugPrint('myAirlines: $myAirlines');

  debugPrint('before myFlights: $myFlights');
  myFlights = await FlightsFirebaseManger.getFlights();
  debugPrint('myFlights: $myFlights');
}