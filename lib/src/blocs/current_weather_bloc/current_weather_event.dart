import 'package:equatable/equatable.dart';

class CurrentWeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentWeatherRequested extends CurrentWeatherEvent {
  final double lon;
  final double lat;
  late bool? requireCurrentLocation;

  CurrentWeatherRequested(
      {required this.lon,
      required this.lat,
      this.requireCurrentLocation = false});
  @override
  List<Object?> get props => [lon, lat];
}
