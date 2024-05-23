import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/airline_model.dart';
import '../../data/models/flight_model.dart';
import '../../data/models/passenger_model.dart';

List<Passenger> myPassengers = [];
List<Flight> myFlights = [];
List<Airline> myAirlines = [];

List<String> passportNumbersList = [];

NotificationSettings? notificationSettings;

SharedPreferences? sharedPreferences;