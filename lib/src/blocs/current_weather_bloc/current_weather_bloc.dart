import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/current_weather.dart';
import '../../services/weather_service/weather_service.dart';
import 'current_weather_event.dart';
import 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  WeatherService service;

  CurrentWeatherBloc({required this.service}) : super(CurrentWeatherInitial()) {
    on<CurrentWeatherRequested>((event, emit) async {
      try {
        emit(CurrentWeatherLoadInProgress());
        final currentWeather = await service.getCurrentWeather(
            lon: event.lon, lat: event.lat) as CurrentWeather;
        emit(CurrentWeatherLoadSuccess(currentWeather: currentWeather));
      } catch (error) {
        emit(CurrentWeatherLoadFailure());
      }
    });
  }
}
