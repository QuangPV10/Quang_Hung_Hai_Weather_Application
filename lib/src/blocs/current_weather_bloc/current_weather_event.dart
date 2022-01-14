import 'package:equatable/equatable.dart';

class CurrentWeatherEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class CurrentWeatherRequested extends CurrentWeatherEvent{
  final double lon;
  final double lat;

  CurrentWeatherRequested({required this.lon,required this.lat});
  @override
  List<Object?> get props => [lon,lat];
}