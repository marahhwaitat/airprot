

import '../../core/global/global.dart';

class PassengerLocal{

  //passenger Passport Number
  static String? getPassportNum(){
    return sharedPreferences!.getString('passportNum');
  }
  static editPassportNum(String passportNum){
    sharedPreferences!.setString('passportNum', passportNum);
  }
}