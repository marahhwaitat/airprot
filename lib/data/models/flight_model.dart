
class Flight {
  String airlineId;

  String flightId;

  int flightNum;
  int gateNum;

  String origin;
  String destination;

  DateTime? departureTime = DateTime.now();
  DateTime? arrivalTime = DateTime.now();

  DateTime? openGateTime = DateTime.now();
  DateTime? closeGateTime = DateTime.now();

  List<String> passengerIds;

  Flight({
    this.airlineId = '',
    this.flightId = '',
    this.flightNum = 0,
    this.gateNum = 0,
    this.origin = '',
    this.destination = '',
    this.departureTime,
    this.arrivalTime,
    this.openGateTime,
    this.closeGateTime,
    this.passengerIds = const [],
  });

  factory Flight.fromMap(Map<String, dynamic> map, String id) {
    return Flight(
        airlineId: map['airlineId'] ?? '',
        flightId: id,
        flightNum: map['flightNum'] ?? 0,
        gateNum: map['gateNum'] ?? 0,
        origin: map['origin'] ?? '',
        destination: map['destination'] ?? '',
        departureTime: map['departureTime'] == null
            ? DateTime.now() : DateTime.parse(map['departureTime'] as String),
        arrivalTime: map['arriveTime'] == null
            ? DateTime.now() : DateTime.parse(map['arriveTime'] as String),
        openGateTime: map['openGateTime'] == null
            ? DateTime.now() : DateTime.parse(map['openGateTime'] as String),
        closeGateTime: map['closeGateTime'] == null
            ? DateTime.now() : DateTime.parse(map['closeGateTime'] as String),
        passengerIds: List<String>.from(map['passengerIds'] ?? const []),
    );
  }

  static Map<String, dynamic> toMap(Flight flight) => {
    'airlineId': flight.airlineId,
    'flightNum': flight.flightNum,
    'gateNum': flight.gateNum,
    'origin': flight.origin,
    'destination': flight.destination,
    'departureTime': flight.departureTime!.toIso8601String(),
    'arriveTime': flight.arrivalTime!.toIso8601String(),
    'openGateTime': flight.openGateTime!.toIso8601String(),
    'closeGateTime': flight.closeGateTime!.toIso8601String(),
    'passengerIds': flight.passengerIds,
  };
}
