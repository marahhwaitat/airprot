import 'dart:async';

import 'package:airport/core/global/global.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/flight_model.dart';
import '../../data/repos/airlines_firebase.dart';
import '../../data/repos/flights_firebase.dart';

part 'flight_event.dart';
part 'flight_state.dart';

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  FlightBloc() : super(FlightInitial()) {
    on<FetchFlightsEvent>(fetchFlightsEvent);
    on<UpdateFlightsEvent>(updateFlightsEvent);
  }

  FutureOr<void> fetchFlightsEvent(
      FetchFlightsEvent event, Emitter<FlightState> emit) async {

    emit(FlightsLoadingState());
    try {
      debugPrint('before myAirlines: $myAirlines');
      myAirlines = await AirlinesFirebaseManger.getAirlines();
      debugPrint('myAirlines: $myAirlines');

      debugPrint('before myFlights: $myFlights');
      myFlights = await FlightsFirebaseManger.getFlights();
      debugPrint('myFlights: $myFlights');
      emit(FlightsSuccessfulState());
    } catch (e) {
      emit(FlightsErrorState(error: e.toString()));
    }
  }

  FutureOr<void> updateFlightsEvent(
      UpdateFlightsEvent event, Emitter<FlightState> emit) async {

    emit(FlightsLoadingState());
    try {
      await FlightsFirebaseManger.updateFlight(event.flight);

      myAirlines = await AirlinesFirebaseManger.getAirlines();
      debugPrint('myAirlines: $myAirlines');

      await FlightsFirebaseManger.updateFlight(event.flight);

      emit(FlightsSuccessfulState());
    } catch (e) {
      emit(FlightsErrorState(error: e.toString()));
    }
  }
}
