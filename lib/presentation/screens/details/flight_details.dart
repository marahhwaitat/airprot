import 'dart:async';

import 'package:airport/core/utils/utils.dart';
import 'package:airport/presentation/screens/add/add_passenger.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../core/global/global.dart';
import '../../../core/utils/colors.dart';
import '../../../data/models/flight_model.dart';
import '../../../data/models/passenger_model.dart';

class FlightDetails extends StatefulWidget {
  final String airlineId, flightId;
  const FlightDetails({super.key, required this.airlineId, required this.flightId});

  @override
  FlightDetailsState createState() => FlightDetailsState();
}

class FlightDetailsState extends State<FlightDetails> {
  late Flight flight;
  late Timer _timer;
  late Duration remainingTime;

  @override
  void initState() {
    super.initState();
    flight = myFlights.firstWhere((flight) => flight.flightId == widget.flightId);  // get flight by id
    remainingTime = flight.departureTime!.difference(DateTime.now()); // calc remaining time
    _startTimer();  // Start the timer
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Calculate the remaining time until departure
        remainingTime = flight.departureTime!.difference(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${flight.flightNum}', style: context.getThemeTextStyle().titleLarge,),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPassenger(
                    airlineId: widget.airlineId, flightId: widget.flightId,
                  )));
            },
            child: Text('Add Passenger', style: TextStyle(color: primary),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(size, 'Flight Details'),
              _buildInfoTable([
                {'label': 'Departure Time',
                  'value': DateFormat('dd/MM,  HH:mm a').format(flight.departureTime!)},
                {'label': 'Arrival Time',
                  'value': DateFormat('dd/MM,  HH:mm a').format(flight.arrivalTime!)},
                {'label': 'Gate Number', 'value': '${flight.gateNum}'},
                {'label': 'Open Gate Time',
                  'value': DateFormat('HH:mm a').format(flight.openGateTime!)},
                {'label': 'Close Gate Time',
                  'value': DateFormat('HH:mm a').format(flight.closeGateTime!)},
                {'label': 'Remaining Time', 'value': _formatRemainingTime(remainingTime), 'color': ''},
              ]),
              SizedBox(height: size.height * 0.02),

              _buildSectionTitle(size, 'Passengers Details'),
              SizedBox(height: size.height * 0.02),

              ...flight.passengerIds.map((passengerId) => _buildPassengerInfoTable(size, passengerId)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(Size size, String title) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.01),
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

  Widget _buildPassengerInfoTable(Size size, passengerId) {
    Passenger passenger = myPassengers.firstWhere((passenger) => passenger.passengerId == passengerId);

    return Card(
      child: Container(
        padding: EdgeInsets.only(bottom: size.height * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Passenger Name:',
                      style: TextStyle(
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
                      passenger.passengerName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Passport Number:',
                      style: TextStyle(
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
                      passenger.passportNum,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Class Type:',
                      style: TextStyle(
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
                      passenger.classType,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Sat Number:',
                      style: TextStyle(
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
                      '${passenger.satNum}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
