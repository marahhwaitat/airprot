part of 'flight_bloc.dart';

@immutable
sealed class FlightState {}

final class FlightInitial extends FlightState {}

final class FlightsSuccessfulState extends FlightState {}
final class FlightsLoadingState extends FlightState {}
final class FlightsErrorState extends FlightState {
  final String error;
  FlightsErrorState({required this.error});
}
