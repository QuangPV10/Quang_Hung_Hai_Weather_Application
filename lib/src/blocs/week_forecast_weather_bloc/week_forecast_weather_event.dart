import 'package:equatable/equatable.dart';

class WeekForeCastWeatherEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class WeekForeCastWeatherRequested extends WeekForeCastWeatherEvent{
  final double lon;
  final double lat;

  WeekForeCastWeatherRequested({required this.lon,required this.lat});
  @override
  List<Object?> get props => [lon,lat];
}