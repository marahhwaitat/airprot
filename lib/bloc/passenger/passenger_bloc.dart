import 'dart:async';

import 'package:airport/core/global/global.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/repos/passengers_firebase.dart';

part 'passenger_event.dart';
part 'passenger_state.dart';

class PassengerBloc extends Bloc<PassengerEvent, PassengerState> {
  PassengerBloc() : super(PassengerInitial()) {
    on<FetchPassengersEvent>(fetchPassengersEvent);
  }

  FutureOr<void> fetchPassengersEvent(
      FetchPassengersEvent event, Emitter<PassengerState> emit) async {

    emit(FetchPassengersLoadingState());
    try {
      myPassengers = await PassengersFirebaseManger.getPassengers();
      debugPrint('myPassengers: $myPassengers');

      emit(FetchPassengersSuccessfulState());
    } catch (e) {
      emit(FetchPassengersErrorState(error: e.toString()));
    }
  }
}

