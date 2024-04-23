import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/passenger_model.dart';

class PassengersFirebaseManger {
  static Future<List<Passenger>> getPassengers() async {
    QuerySnapshot snapshots;
    try {
      snapshots =
          await FirebaseFirestore.instance.collection('Passengers').get();

      List<Passenger> passengers = [];

      Map<String, dynamic> map;

      for (var snapshot in snapshots.docs) {
        map = snapshot.data() as Map<String, dynamic>;

        passengers
            .add(Passenger.fromMap(map, snapshot.id));
      }

      return passengers;
    } on FirebaseException {
      throw Exception();
    }
  }
}