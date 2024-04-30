import 'package:cloud_firestore/cloud_firestore.dart';


class AuthFirebaseManger {
  static Future<bool> login(bool airport, String userName, String password) async {
    DocumentSnapshot snapshots;
    try {
      snapshots =
      await FirebaseFirestore.instance.collection('Auth')
          .doc(airport? 'Airport' : 'Airline').get();


      Map<String, dynamic> map = snapshots.data() as Map<String, dynamic>;
      return map[userName] == password;

    } on FirebaseException {
      throw Exception();
    }
  }
}