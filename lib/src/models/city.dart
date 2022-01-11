import 'package:equatable/equatable.dart';

class City extends Equatable {
  final num id;
  final String name;
  final String country;
  final Coordinate coordinate;

  const City(
      {required this.id,
      required this.name,
      required this.country,
      required this.coordinate
      }
      );

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json['id'],
        name: json['name'],
        country: json['country'],
        coordinate: Coordinate.fromJson(json['coord']) 
        );
  }

  @override
  List<Object?> get props => [id, name, country];
}

class Coordinate extends Equatable {
  final num longitude;
  final num latitude;

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

  @override
  List<Object?> get props => [longitude, latitude];
}
