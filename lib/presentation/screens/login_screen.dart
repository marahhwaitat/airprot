import 'package:flutter/material.dart';

import 'flight_info_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),

              SizedBox(
                  height: size.height * 0.4,
                  width: size.width,
                  child: Image.asset('assets/images/login.png')
              ),

              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //mail
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          labelText: 'Passport',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          prefixIcon: Icon(Icons.mail, color: Theme.of(context).primaryColor,),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your Passport Number' : null,
                      ),

                      // if (_errorMessage != null)
                      //   Text(_errorMessage!,
                      //       style: const TextStyle(color: Colors.red)
                      //   ),

                      SizedBox(height: size.height * 0.02,),

                      //login
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => const FlightInfoScreen()));
                                //val.toast(context, "Login Successfully");
                              }
                            },
                          child: const Text('Login'),
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