import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';
import '../../../data/repos/passenger_local.dart';
import '../details/passenger_details.dart';

class PassengerLogin extends StatefulWidget {
  const PassengerLogin({super.key});

  @override
  State<PassengerLogin> createState() => _PassengerLoginState();
}

class _PassengerLoginState extends State<PassengerLogin> {

  final _formKey = GlobalKey<FormState>();

  final _passportController = TextEditingController();

  String? _errorMessage;

  @override
  void dispose() {
    _passportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.02),
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

              SizedBox(height: size.height * 0.02),

              SizedBox(
                  height: size.height * 0.3,
                  width: size.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('assets/images/image.jpeg', fit: BoxFit.cover,)
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

                      //passport
                      TextFormField(
                        controller: _passportController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          labelText: 'Passport',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your Passport Number' : null,
                      ),
                      SizedBox(height: size.height * 0.02,),


                      SizedBox(height: size.height * 0.02,),
                      if (_errorMessage != null)
                        Text(_errorMessage!,
                            style: const TextStyle(color: Colors.red)
                        ),

                      SizedBox(height: size.height * 0.02,),

                      //login
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              if(existingPassenger(_passportController.text)) {
                                PassengerLocal.editPassportNum(_passportController.text);
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    PassengerDetails(passportNum: _passportController.text)));
                              } else {
                                setState(() => _errorMessage = 'Passenger Not Fount');
                              }}
                          },
                          child: Text('Find', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}