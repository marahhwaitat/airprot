import 'dart:async';
import 'package:flutter/material.dart';

class FlightInfoScreen extends StatefulWidget {
  const FlightInfoScreen({super.key});

  @override
  FlightInfoScreenState createState() => FlightInfoScreenState();
}

class FlightInfoScreenState extends State<FlightInfoScreen> {
  late Timer _timer;
  late DateTime departureTime;

  @override
  void initState() {
    super.initState();
    // Set the departure time (10:00 AM in this example)
    departureTime = DateTime.now().add(const Duration(hours: 10));
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
    // Calculate the remaining time until departure
    Duration remainingTime = departureTime.difference(DateTime.now());

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
              {'label': 'Passenger Name', 'value': 'John Doe'},
              {'label': 'Passport Number', 'value': 'AB123456'},
              {'label': 'Destination', 'value': 'New York'},
            ]),
            const SizedBox(height: 20.0),
            _buildSectionTitle('Flight Details'),
            _buildInfoTable([
              {'label': 'Departure Time', 'value': '10:00 AM'},
              {'label': 'Arrival Time', 'value': '12:00 PM'},
              {'label': 'Gate Number', 'value': '12A'},
              {
                'label': 'Remaining Time',
                'value': _formatRemainingTime(remainingTime)
              },
            ]),
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
          1: FlexColumnWidth(2),
        },
        children: data.map((item) {
          final label = item['label'] ?? '';
          final value = item['value'] ?? '';
          return TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$label:',
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
                    value,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
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
