import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/airline_model.dart';

class AirlinesFirebaseManger {
  static Future<List<Airline>> getAirlines() async {
    QuerySnapshot snapshots;
    try {
      snapshots = await FirebaseFirestore.instance.collection('Airlines').get();

      List<Airline> airline = [];
      Map<String, dynamic> map;

      for (var snapshot in snapshots.docs) {
        map = snapshot.data() as Map<String, dynamic>;
        airline.add(Airline.fromMap(map, snapshot.id));
      }

      return airline;
    } on FirebaseException {
      throw Exception();
    }
  }
}