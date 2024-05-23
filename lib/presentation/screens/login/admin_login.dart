import 'package:airport/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/global/global.dart';
import '../../../data/repos/auth_firebase.dart';
import '../show/show_airlines.dart';
import '../show/show_flights.dart';

class AdminLogin extends StatefulWidget {
  final bool airport;
  const AdminLogin({super.key, required this.airport});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorMessage;

  bool _obscureText = true;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.airport? 'Airport Login': 'Airline Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),

              SizedBox(
                  height: size.height * 0.4,
                  width: size.width,
                  child: Image.asset('assets/images/image.jpeg')
              ),

              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          labelText: 'User Name',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor,),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your User Name' : null,
                      ),
                      SizedBox(height: size.height * 0.02,),

                      //password
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          labelText: 'Password',
                          labelStyle: Theme.of(context).textTheme.bodySmall,
                          prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).primaryColor,),
                          suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscureText = !_obscureText),
                              icon: Icon(_obscureText? CupertinoIcons.eye_solid : CupertinoIcons.eye_slash_fill)
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        validator: (value) => value == null || value.isEmpty ?
                        'Please enter the password' : value.length<6 ?
                        'the minimum length is 6 character': null,
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
                              AuthFirebaseManger.login(
                                    widget.airport, _userNameController.text, _passwordController.text)
                                    .then((value) {
                                      if(value != null){
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => widget.airport?
                                          const ShowAirlines():
                                          ShowFlights(
                                            airline: myAirlines.firstWhere((airline) => airline.id == value),
                                            isAirline: false
                                          ),
                                        ));
                                      }
                                      else{
                                        setState(() {
                                          _errorMessage = 'User Name or Password not not correct';
                                        });
                                      }
                                }).catchError((e){
                                  setState((){
                                    _errorMessage = e.toString();
                                  });
                                });
                            }
                          },
                          child: Text('Login',
                            style: context.getThemeTextStyle().titleLarge!.copyWith(color: Colors.white)
                          ),
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