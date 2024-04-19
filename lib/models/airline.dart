class Airline {
  String id;
  String name;
  List<String> flightIds;

  Airline({
    this.id = '',
    this.name = '',
    this.flightIds = const [],
  });

  factory Airline.fromMap(Map<String, dynamic> map, String id) {
    return Airline(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      flightIds: map['flightIds'] ?? []
    );
  }

  static Map<String, dynamic> toMap(Airline airline) => {
    'id': airline.id,
    'name': airline.name,
    'flightIds': airline.flightIds
  };
}
