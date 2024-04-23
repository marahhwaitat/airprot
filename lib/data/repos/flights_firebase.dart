import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/flight_model.dart';

class FlightsFirebaseManger {
  static Future<List<Flight>> getFlights() async {
    QuerySnapshot snapshots;
    try {
      snapshots =
          await FirebaseFirestore.instance.collection('Flights').get();

      List<Flight> flight = [];

      Map<String, dynamic> map;

      for (var snapshot in snapshots.docs) {
        map = snapshot.data() as Map<String, dynamic>;

        flight
            .add(Flight.fromMap(map, snapshot.id));
      }

      return flight;
    } on FirebaseException {
      throw Exception();
    }
  }
}