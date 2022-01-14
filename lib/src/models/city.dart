class City {
  final num id;
  final String name;
  final Coordinate coordinate;

  const City({required this.id, required this.name, required this.coordinate});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json['id'],
        name: json['name'],
        coordinate: Coordinate.fromJson(json['coord']));
  }
}

class Coordinate {
  final double longitude;
  final double latitude;

  const Coordinate({
    required this.longitude,
    required this.latitude,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      longitude: json['lon'],
      latitude: json['lat'],
    );
  }
}
