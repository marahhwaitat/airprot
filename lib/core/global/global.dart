import '../../bloc/flight/flight_bloc.dart';
import '../../bloc/passenger/passenger_bloc.dart';

import '../../data/models/airline_model.dart';
import '../../data/models/flight_model.dart';
import '../../data/models/passenger_model.dart';

PassengerBloc passengerBloc = PassengerBloc();
FlightBloc flightBloc = FlightBloc();

List<Passenger> myPassengers = [];
List<Flight> myFlights = [];
List<Airline> myAirlines = [];