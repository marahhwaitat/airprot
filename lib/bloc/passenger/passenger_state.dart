part of 'passenger_bloc.dart';

@immutable
sealed class PassengerState {}

final class PassengerInitial extends PassengerState {}

final class FetchPassengersSuccessfulState extends PassengerState {}
final class FetchPassengersLoadingState extends PassengerState {}
final class FetchPassengersErrorState extends PassengerState {
  final String error;
  FetchPassengersErrorState({required this.error});
}
