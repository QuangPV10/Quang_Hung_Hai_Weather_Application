import 'package:equatable/equatable.dart';
import 'package:quang_hung_hai_weather_application/src/models/position.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherRequested extends WeatherEvent {
  final Position position;

  WeatherRequested({required this.position});

  @override
  List<Object> get props => [position];
}
