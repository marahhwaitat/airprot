import 'dart:async';

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
    if(passenger.passportNum == passportNum) return true;
  }
  return false;
}

Future<void> fetchPassengersEvent() async {
  myPassengers = await PassengersFirebaseManger.getPassengers();
  passportNumbersList = getPassportNumbersList();
}

Future<void> fetchFlightsEvent() async {
  myAirlines = await AirlinesFirebaseManger.getAirlines();
  myFlights = await FlightsFirebaseManger.getFlights();
}

List<String> getPassportNumbersList(){
  return myPassengers.map((passenger) => passenger.passportNum ).toList();
}

bool isPassportExist(String passportNum, String flightId){
  return myPassengers.firstWhere((passenger) => passenger.passportNum == passportNum).flightIds.contains(flightId);
}

String formatRemainingTime(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  return duration.inSeconds < 0? 'Ended' : '$hours:${formatTimeComponent(minutes)}:${formatTimeComponent(seconds)}';
}

String formatTimeComponent(int component) {
  return component < 10 ? '0$component' : '$component';
}

//date
DateTime? _selectedDate = DateTime.now();

Future<DateTime?> selectDate(BuildContext context, {DateTime? initialDate}) async {
  await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 62)),
  ).then((selectedDate) async {
    if(selectedDate == null) {
      _selectedDate = null;
    } else {
      await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 0, minute: 0)
      ).then((selectedTime) {
        if(selectedTime == null) {
          _selectedDate = null;
        } else {
          _selectedDate = selectedDate.copyWith(hour: selectedTime.hour, minute: selectedTime.minute);
        }
      });
    }
  });
  return _selectedDate;
}

Future<DateTime?> selectTime(BuildContext context, DateTime time) async {
  await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 0, minute: 0)
  ).then((selectedTime){
    if(selectedTime == null) {
      _selectedDate = null;
    } else {
      _selectedDate = time.copyWith(hour: selectedTime.hour, minute: selectedTime.minute);
    }
  });
  return _selectedDate;
}