import 'package:equatable/equatable.dart';

import '../../models/current_weather.dart';

class CurrentWeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoadInProgress extends CurrentWeatherState {}

class CurrentWeatherLoadSuccess extends CurrentWeatherState {
  final CurrentWeather currentWeather;

  CurrentWeatherLoadSuccess({required this.currentWeather});

  @override
  List<Object?> get props => [currentWeather];
}

class CurrentWeatherLoadFailure extends CurrentWeatherState {}
