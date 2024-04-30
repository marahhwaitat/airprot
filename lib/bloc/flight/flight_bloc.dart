import 'dart:async';

import 'package:airprot/core/global/global.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/flight_model.dart';
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
      myFlights = await FlightsFirebaseManger.getFlights();
      emit(FlightsSuccessfulState());
    } catch (e) {
      emit(FlightsErrorState(error: e.toString()));
    }
  }

  FutureOr<void> updateFlightsEvent(
      UpdateFlightsEvent event, Emitter<FlightState> emit) async {

    emit(FlightsLoadingState());
    try {
      await FlightsFirebaseManger.updateFlights(event.flight);
      myFlights = await FlightsFirebaseManger.getFlights();
      emit(FlightsSuccessfulState());
    } catch (e) {
      emit(FlightsErrorState(error: e.toString()));
    }
  }
}
