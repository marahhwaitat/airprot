import 'package:flutter/material.dart';

import '../global/global.dart';

// import 'package:fluttertoast/fluttertoast.dart';
//
// class Helper{
//   static toast(BuildContext context ,String message){
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Theme.of(context).shadowColor,
//         fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
//     );
//   }
// }

extension ContextEx on BuildContext
{
  TextTheme getThemeTextStyle()
  {
    return Theme.of(this).textTheme;
  }
}

bool existingPassenger(String passportNum){
  myPassengers.map((passenger) {
    if(passportNum == passenger.passportNum) return true;
  });
  return false;
}