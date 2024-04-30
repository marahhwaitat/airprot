import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/flight_model.dart';

class AddFlight extends StatefulWidget {
  const AddFlight({super.key});

  @override
  State<AddFlight> createState() => _AddFlightState();
}

class _AddFlightState extends State<AddFlight> {
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

  final _flightNumController = TextEditingController();
  final _gateNumController = TextEditingController();

  final _originController = TextEditingController();
  final _destinationController = TextEditingController();


  bool _uploading = false;

  @override
  void dispose() {
    _flightNumController.dispose();
    _gateNumController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.03),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).shadowColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.02),

                      Text('Adding Flight',
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: size.height * 0.01),

                      const Text(
                        'please enter the required data',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(height: size.height * 0.05),

                      //flight num + gate num
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
                              child: TextFormField(
                                controller: _flightNumController,
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty? 'Please Enter Flight Number' : null,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  hintText: 'Flight Number',
                                  hintStyle: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
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
                                  hintText: 'gate number',
                                  hintStyle: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),

                      //origin
                      TextFormField(
                        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                        controller: _originController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: 'Origin',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter origin'
                            : null,
                      ),
                      SizedBox(height: size.height * 0.02),

                      //destination
                      TextFormField(
                        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                        controller: _destinationController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: 'Destination',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          prefixIcon: Icon(
                            Icons.question_mark,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter destination'
                            : null,
                      ),
                      SizedBox(height: size.height * 0.02),

                      //departureTime and arrivalTime
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Theme.of(context).hintColor,
                                  elevation: 0,
                                  side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6), ),
                                  foregroundColor: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {},//=> val.selectTime(context),
                                icon: Icon(Icons.access_time, color: Theme.of(context).primaryColor),
                                label: Text(
                                  'departure Time',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Theme.of(context).hintColor,
                                  elevation: 0,
                                  side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6), ),
                                  foregroundColor: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {},//=> val.selectTime(context),
                                icon: Icon(Icons.access_time, color: Theme.of(context).primaryColor),
                                label: Text(
                                  'departure Time',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),

                      //openGateTime and closeGateTime
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Theme.of(context).hintColor,
                                  elevation: 0,
                                  side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6), ),
                                  foregroundColor: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {},//=> val.selectTime(context),
                                icon: Icon(Icons.access_time, color: Theme.of(context).primaryColor),
                                label: Text(
                                  'departure Time',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: Theme.of(context).hintColor,
                                  elevation: 0,
                                  side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.6), ),
                                  foregroundColor: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {},//=> val.selectTime(context),
                                icon: Icon(Icons.access_time, color: Theme.of(context).primaryColor),
                                label: Text(
                                  'departure Time',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),


                      SizedBox(height: size.height * 0.01),
                      if (_errorMessage != null) Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: size.height * 0.04),

                      //add or cancel
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
                                      Navigator.pop(context);
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
                                  onPressed: _uploading
                                      ? null
                                      : () async {
                                          if (!_formKey.currentState!
                                              .validate()
                                          ) {
                                            setState(() {
                                              _errorMessage =
                                                  'please add data first';
                                            });
                                          } else {
                                            // Set `_uploading` to true before starting the upload
                                            setState(() {
                                              _uploading = true;
                                            });

                                            // Call the function to upload data
                                            await uploadFlight(context);

                                            // Set `_uploading` to false after the upload is complete
                                            setState(() {
                                              _uploading = false;
                                            });
                                          }
                                        },
                                  child: Text(
                                    _uploading ? 'Adding...' : 'Add',
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
            ],
          ),
        ),
      ),
    );
  }

  Future uploadFlight(BuildContext context) async {

    try {

      CollectionReference questionCollection =
          FirebaseFirestore.instance.collection('');

      //add question
      await questionCollection.doc('Flights').set(Flight.toMap(Flight(
        airlineId: '',
        origin: _originController.text,
        destination: _destinationController.text,
        flightNum: int.parse(_flightNumController.text),
        gateNum: int.parse(_gateNumController.text),
        passengerIds: []
      )));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flight added successfully'), duration: Duration(seconds: 1)),
        );
      }
      _clearFields();
    } catch (e) {
      _errorMessage = 'Error: $e';
    }
  }

  void _clearFields() {
    _originController.clear();
    _destinationController.clear();
    _flightNumController.clear();
    _gateNumController.clear();
    _errorMessage = null;

  }
}
