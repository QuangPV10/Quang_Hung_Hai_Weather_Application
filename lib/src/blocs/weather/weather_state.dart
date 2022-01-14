import 'package:equatable/equatable.dart';
import 'package:quang_hung_hai_weather_application/src/models/current_weather.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadFailure extends WeatherState {
  final String? errorMessage;

  WeatherLoadFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final CurrentWeather weather;

  WeatherLoadSuccess({required this.weather});

  @override
  List<Object?> get props => [weather];
}
