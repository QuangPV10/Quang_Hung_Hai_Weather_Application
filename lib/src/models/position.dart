import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final double lat;
  final double lon;
  late double? zoom = 1;

  set setZoom(double zoom) {
    this.zoom = zoom;
  }

  Position({required this.lat, required this.lon, this.zoom});

  @override
  List<Object?> get props => [lat, lon, zoom];
}
