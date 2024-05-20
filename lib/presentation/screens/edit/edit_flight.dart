import 'dart:async';

import 'package:airport/core/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../core/global/global.dart';
import '../../../core/utils/colors.dart';
import '../../../data/models/flight_model.dart';
import '../../../data/repos/flights_firebase.dart';

class EditFlight extends StatefulWidget {
  final String airlineId, flightId;
  const EditFlight({super.key, required this.airlineId, required this.flightId});

  @override
  EditFlightState createState() => EditFlightState();
}

class EditFlightState extends State<EditFlight> {
  late Flight flight;
  late Timer _timer;
  late Duration remainingTime;
  bool edited = false;

  String? _errorMessage;

  Duration? flightTime;
  Duration? gateTime;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _gateNumController;
  
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    flight = myFlights.firstWhere((flight) => flight.flightId == widget.flightId); // get flight by id
    flightTime = flight.arrivalTime!.difference(flight.departureTime!);
    gateTime = flight.closeGateTime!.difference(flight.openGateTime!);
    remainingTime = flight.departureTime!.difference(DateTime.now()); // calc remaining time
    _gateNumController = TextEditingController(text: flight.gateNum.toString());
    _startTimer();  // Start the timer
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _gateNumController.dispose();
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
          if(!edited)
          TextButton(
            onPressed: (){
              if(remainingTime.inSeconds < 0) {
                setState(() => _errorMessage = 'Ended Flight');
              } else {
                setState(() => edited = true);
              }
            },
            child: Text('Edit Flight', style: TextStyle(color: primary),),
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

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200],
                ),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                  },
                  children: [
                    // departure Time
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Departure Time',
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
                            child: Row(
                              children: [
                                Text(
                                    DateFormat('dd/MM,  HH:mm a').format(flight.departureTime!),
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                                if(edited) IconButton(
                                  onPressed: () async {
                                    _errorMessage = null;
                                    await selectDate(context, initialDate: flight.departureTime).then((value) {
                                      if(value != null) {
                                        setState(() {
                                          flight.departureTime = value;
                                          flight.arrivalTime = flight.departureTime!.add(flightTime!);
                                        });
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.edit, size: 15, color: Colors.blue,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // arrival Time
                    _buildTableRow('Arrival Time', DateFormat('dd/MM,  HH:mm a').format(flight.arrivalTime!)),
                    // gate num
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Gate Number',
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
                            child: edited?
                            SizedBox(
                              height: size.height * 0.07,
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _gateNumController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => value == null || value.isEmpty ?
                                  'Please Enter Gate Number': null,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    errorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    hintText: 'Gate Number',
                                    hintStyle: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ) :
                            Text(
                              '${flight.gateNum}',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // open gate
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Open Gate Time',
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
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('HH:mm a').format(flight.openGateTime!),
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                                if(edited) IconButton(
                                  onPressed: () async {
                                    _errorMessage = null;
                                    await selectTime(context, flight.departureTime!).then((value) {
                                      if(value != null) {
                                        setState(() {
                                        flight.openGateTime = value;
                                        flight.closeGateTime = flight.openGateTime!.add(gateTime!);
                                      });
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.edit, size: 15, color: Colors.blue,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // close gate
                    _buildTableRow('Close Gate Time', DateFormat('HH:mm a').format(flight.closeGateTime!)),
                    //remaining time
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Remaining Time',
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
                              formatRemainingTime(remainingTime),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.02),
              if (_errorMessage != null) Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
              SizedBox(height: size.height * 0.04),

              //add or cancel
              if(edited)
              Row(
                children: [
                  //cancel
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02),
                      child: SizedBox(
                          height: size.height * 0.08,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                              backgroundColor: Theme.of(context).focusColor,
                              foregroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              setState(() => edited = false);
                            },
                            child: const Text('Cancel'),
                          )),
                    ),
                  ),

                  //add
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02),
                      child: SizedBox(
                        height: size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: _editing ? null : () async {
                            if(_formKey.currentState!.validate()){
                              if(flight.departureTime!.isBefore(flight.closeGateTime!) ||
                                  flight.departureTime!.difference(flight.closeGateTime!).inHours > 2){
                              setState(() => _errorMessage = 'please enter Valid dates');
                            } else{
                                setState(() =>_editing = true);
                                await updateFlight(context);
                                setState(() {_editing = false; edited = false;});
                              }

                            }
                            },
                          child: Text(
                            _editing ? 'editing...' : 'edit',
                            style:
                            const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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

  TableRow _buildTableRow(String label, String value){
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
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
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future updateFlight(BuildContext context) async {
    try {
      //update Flight

      flight.gateNum = int.parse(_gateNumController.text);

      await FlightsFirebaseManger.updateFlight(flight);

      await fetchFlightsEvent();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flight updated successfully'), duration: Duration(seconds: 1)),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
