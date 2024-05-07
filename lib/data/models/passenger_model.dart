class Passenger {
  String airlineId;
  String flightId;
  String passengerId;

  String passengerName;
  String passportNum;

  String classType;
  int satNum;

  Passenger({
    this.airlineId = '',
    this.flightId = '',
    this.passengerId = '',
    this.passengerName = '',
    this.passportNum = '',
    this.classType = '',
    this.satNum = 0,
  });

  factory Passenger.fromMap(Map<String, dynamic> map, String id) {
    return Passenger(
      airlineId: map['airlineId'] ?? '',
      flightId: map['flightId'] ?? '',
      passengerId: id,
      passengerName: map['passengerName'] ?? '',
      passportNum: map['passportNum'] ?? '',
      classType: map['classType'] ?? '',
      satNum: map['satNum'] ?? 0,
    );
  }

  static Map<String, dynamic> toMap(Passenger passenger) => {
    'airlineId': passenger.airlineId,
    'flightId': passenger.flightId,
    'passengerName': passenger.passengerName,
    'passportNum': passenger.passportNum,
    'classType': passenger.classType,
    'satNum': passenger.satNum,
  };
}
