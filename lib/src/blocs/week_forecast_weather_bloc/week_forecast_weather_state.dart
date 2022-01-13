import 'package:equatable/equatable.dart';

import '../../models/week_forecast_weather.dart';

class WeekForeCastWeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeekForeCastWeatherInitial extends WeekForeCastWeatherState {}

class WeekForeCastWeatherLoadInProgress extends WeekForeCastWeatherState {}

class WeekForeCastWeatherLoadSuccess extends WeekForeCastWeatherState {
  final WeekForeCastWeather weekForeCastWeather;
  WeekForeCastWeatherLoadSuccess({required this.weekForeCastWeather});
  @override
  // TODO: implement props
  List<Object?> get props => [weekForeCastWeather];
}

class WeekForeCastWeatherLoadFailure extends WeekForeCastWeatherState {}
