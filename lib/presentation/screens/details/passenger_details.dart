import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../core/global/global.dart';
import '../../../data/models/flight_model.dart';
import '../../../data/models/passenger_model.dart';

class PassengerDetails extends StatefulWidget {
  final String passportNum;
  const PassengerDetails({super.key, required this.passportNum});

  @override
  PassengerDetailsState createState() => PassengerDetailsState();
}

class PassengerDetailsState extends State<PassengerDetails> {
  late Timer _timer;
  late Passenger _passenger;
  late List<Flight> _flights;

  @override
  void initState() {
    super.initState();
    _passenger = myPassengers.firstWhere((passenger) => passenger.passportNum == widget.passportNum);
    debugPrint('_passenger: $_passenger');
    _flights = _passenger.flightIds.map((flightId) => myFlights.
    firstWhere((flight) => flight.flightId == flightId)).toList();
    debugPrint('_flight: $_flights');
    // Start the timer
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Update the UI every second to reflect the remaining time
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Passenger Details'),
            _buildInfoTable([
              {'label': 'Passenger Name', 'value': _passenger.passengerName},
              {'label': 'Passport Number', 'value': _passenger.passportNum},
              //{'label': 'Class ', 'value': _flights.origin},
              //{'label': 'Destination', 'value': _flights.destination},
            ]),
            const SizedBox(height: 20.0),
            _buildSectionTitle('Flight Details'),
            ... _flights.map((flight) => _buildInfoTable([
              {'label': 'Departure Time',
                'value': DateFormat('dd/MM,  HH:mm a').format(flight.departureTime!)},
              {'label': 'Arrival Time',
                'value': DateFormat('dd/MM,  HH:mm a').format(flight.arrivalTime!)},
              {'label': 'Gate Number', 'value': '${flight.gateNum}'},
              {'label': 'Open Gate Time',
                'value': DateFormat('HH:mm a').format(flight.openGateTime!)},
              {'label': 'Close Gate Time',
                'value': DateFormat('HH:mm a').format(flight.closeGateTime!)},
              {'label': 'Remaining Time', 'value': _formatRemainingTime(
                  flight.departureTime!.difference(DateTime.now())), 'color': ''},
            ])),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildInfoTable(List<Map<String, String>> data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
        },
        children: data.map((item) {
          return TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${item['label'] ?? ''}:',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item['value'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: item['color'] == null? Colors.black87 : Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _formatRemainingTime(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '$hours:${_formatTimeComponent(minutes)}:${_formatTimeComponent(seconds)}';
  }

  String _formatTimeComponent(int component) {
    return component < 10 ? '0$component' : '$component';
  }
}
