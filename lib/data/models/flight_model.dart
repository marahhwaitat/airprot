

import 'package:flutter/material.dart';

class Flight {
  String airlineId;

  String flightId;

  int flightNum;
  int gateNum;

  String origin;
  String destination;

  TimeOfDay? departureTime;
  TimeOfDay? arrivalTime;

  TimeOfDay? openGateTime;
  TimeOfDay? closeGateTime;

  List<String> passengerIds;

  Flight({
    this.airlineId = '',
    this.flightId = '',
    this.flightNum = 0,
    this.gateNum = 0,
    this.origin = '',
    this.destination = '',
    this.departureTime,
    this.arrivalTime,
    this.openGateTime,
    this.closeGateTime,
    this.passengerIds = const [],
  });

  factory Flight.fromMap(Map<String, dynamic> map, String id) {
    return Flight(
        airlineId: map['airlineId'] ?? '',
        flightId: map['flightId'] ?? '',
        flightNum: map['flightNum'] ?? 0,
        gateNum: map['gateNum'] ?? 0,
        origin: map['origin'] ?? '',
        destination: map['destination'] ?? '',
        departureTime: map['departureTime'],
        arrivalTime: map['arriveTime'],
        openGateTime: map['openGateTime'],
        closeGateTime: map['closeGateTime'],
        passengerIds: map['passengerIds'] ?? const [],
    );
  }

  static Map<String, dynamic> toMap(Flight airport) => {
    'airlineId': airport.airlineId,
    'flightId': airport.flightId,
    'flightNum': airport.flightNum,
    'gateNum': airport.gateNum,
    'origin': airport.origin,
    'destination': airport.destination,
    'departureTime': airport.departureTime,
    'arriveTime': airport.arrivalTime,
    'openGateTime': airport.openGateTime,
    'closeGateTime': airport.closeGateTime,
    'passengerIds': airport.passengerIds,
  };
}
