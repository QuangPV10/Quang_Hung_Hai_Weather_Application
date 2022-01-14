class City {

  final String name;
  final double longitude;
  final double latitude;
  const City(
      {
      required this.name,
      required this.longitude,
      required this.latitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'],
        latitude: json['coord']['lat'],
        longitude: json['coord']['lon']);
  }
}
