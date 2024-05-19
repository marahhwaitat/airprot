import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/passenger_model.dart';

class PassengersFirebaseManger {
  static Future<List<Passenger>> getPassengers() async {
    QuerySnapshot snapshots;
    try {
      snapshots = await FirebaseFirestore.instance.collection('Passengers').get();

      List<Passenger> passengers = [];
      Map<String, dynamic> map;

      for (var snapshot in snapshots.docs) {
        map = snapshot.data() as Map<String, dynamic>;
        passengers.add(Passenger.fromMap(map, snapshot.id));
      }

      return passengers;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> uploadPassenger(Passenger passenger) async {

    try {

      CollectionReference questionCollection =
      FirebaseFirestore.instance.collection('Passengers');

      //add Passengers
      DocumentReference restaurantDocRef = await questionCollection.add(Passenger.toMap(passenger));
      return restaurantDocRef.id;

    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addFlightIdToPassenger(String passengerId, String flightId) async {
    try {

      FirebaseFirestore.instance.collection('Passengers').doc(passengerId).update({
        'flightIds': FieldValue.arrayUnion([flightId])
      });
    } catch (e) {
      rethrow;
    }
  }
}