import 'package:airport/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/global/global.dart';
import '../../../core/utils/colors.dart';
import '../../../data/models/passenger_model.dart';
import '../../../data/repos/flights_firebase.dart';
import '../../../data/repos/passengers_firebase.dart';

class AddPassenger extends StatefulWidget {
  final String airlineId, flightId;
  const AddPassenger({super.key, required this.airlineId, required this.flightId});

  @override
  State<AddPassenger> createState() => _AddPassengerState();
}

class _AddPassengerState extends State<AddPassenger> {
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;
  String _passportNum = '';

  final _passengerNameController = TextEditingController();

  String _selectedClass = 'A';
  final _satNumController = TextEditingController();

  bool _newPassenger = true;
  bool _uploading = false;

  Passenger _passenger = Passenger();

  @override
  void dispose() {
    _passengerNameController.dispose();
    _satNumController.dispose();
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

                      Text('Adding Passenger',
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: size.height * 0.01),

                      const Text(
                        'please enter the required data',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(height: size.height * 0.05),

                      //passenger name
                      TextFormField(
                        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                        controller: _passengerNameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: 'Passenger Name',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter Passenger Name'
                            : null,
                        enabled: _newPassenger,
                      ),
                      SizedBox(height: size.height * 0.02),

                      //passport num
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return passportNumbersList.where((String dName) {
                            return dName.contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) => _choosePassenger(selection),
                        optionsMaxHeight: size.height * 0.2,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController tEC,
                            FocusNode focusNode,
                            onFieldSubmitted) {
                          return TextFormField(
                            controller: tEC,
                            focusNode: focusNode,
                            onChanged: (String value) {
                              setState(() {
                                  _newPassenger = true;
                                  _passportNum = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                              labelText: 'Passport Number',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              prefixIcon: Icon(Icons.confirmation_num, color: Theme.of(context).primaryColor,),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter Passport Number'
                                : null,
                          );
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Card(
                              child: SizedBox(
                                width: size.width * 0.89,
                                height: size.height * 0.25,
                                child: ListView(
                                  children: options.map((String option) => GestureDetector(
                                      onTap: () => onSelected(option),
                                      child: Padding(
                                        padding: EdgeInsets.all(size.width * 0.01),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                                            child: Icon(Icons.confirmation_num, color: Theme.of(context).primaryColor,),
                                          ),
                                          title: Text(option),
                                        ),
                                      ))).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

                      //class type + sat num
                      if(_newPassenger)
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
                              child: DropdownButton(
                                dropdownColor: primary,
                                value: _selectedClass,
                                items: const [
                                  DropdownMenuItem(value: 'A', child: Text('A')),
                                  DropdownMenuItem(value: 'B', child: Text('B')),
                                  DropdownMenuItem(value: 'C', child: Text('C')),
                                ],
                                onChanged: (val){
                                  setState(() {
                                    _selectedClass = val!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.08,
                              child: TextFormField(
                                controller: _satNumController,
                                keyboardType: TextInputType.number,
                                validator: (value) => value == null || value.isEmpty ?
                                'Please Enter Sat Number': null,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  hintText: 'Sat Number',
                                  hintStyle: Theme.of(context).textTheme.bodySmall,
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
                                              .validate() || _selectedClass == 'class'
                                              || _passportNum == ''
                                          ) {
                                            setState(() => _errorMessage = 'please add data first');
                                          } else if ((!_newPassenger || passportNumbersList.contains(_passportNum)) &&
                                              isPassportExist(_passportNum, widget.flightId)) {
                                            setState(() => _errorMessage = 'Exiting Passenger in same flight');
                                          } else {
                                            setState(() => _uploading = true);
                                            await uploadPassenger(context);
                                            setState(() => _uploading = false);
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

  Future uploadPassenger(BuildContext context) async {

    try {

      if(!_newPassenger){
        _passenger.flightIds.add(widget.flightId);
        PassengersFirebaseManger.addFlightIdToPassenger(_passenger.passengerId, widget.flightId);
      }

      String passengerId = !_newPassenger? _passenger.passengerId :
      await PassengersFirebaseManger.uploadPassenger(Passenger(
        airlineId: widget.airlineId,
        flightIds: [widget.flightId],
        passengerName: _passengerNameController.text,
        passportNum: _passportNum,
        classType: _selectedClass,
        satNum: int.parse(_satNumController.text)
      ));

      await FlightsFirebaseManger.addPassengerId(widget.flightId, passengerId);

      await fetchPassengersEvent();
      await fetchFlightsEvent();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passenger added successfully'), duration: Duration(milliseconds: 200)),
        );
      }
      _clearFields();
    } catch (e) {
      _errorMessage = 'Error: $e';
    }
  }

  void _choosePassenger(String value){
    setState(() {
      _newPassenger = false;
      _passportNum = value;
      _passenger = myPassengers.firstWhere((passenger) =>
      passenger.passportNum == value);
      _passengerNameController.text = _passenger.passengerName;
      _selectedClass = _passenger.classType;
      _satNumController.text = _passenger.satNum.toString();
    });
  }

  void _clearFields() {
    setState(() {
      _passengerNameController.clear();
      _passportNum = '';
      _satNumController.clear();
      _selectedClass = 'A';
      _newPassenger = true;
      _errorMessage = null;
    });
  }
}
