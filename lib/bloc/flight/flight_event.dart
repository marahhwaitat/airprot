part of 'flight_bloc.dart';

@immutable
sealed class FlightEvent {}

class FetchFlightsEvent extends FlightEvent {}
class UpdateFlightsEvent extends FlightEvent {
  final Flight flight;
  UpdateFlightsEvent({required this.flight});
}
