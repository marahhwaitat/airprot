part of 'passenger_bloc.dart';

@immutable
sealed class PassengerEvent {}

class FetchPassengersEvent extends PassengerEvent {}