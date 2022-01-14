import 'package:bloc/bloc.dart';

import '../../models/week_forecast_weather.dart';
import '../../services/weather_service/weather_service.dart';
import './week_forecast_weather_event.dart';
import './week_forecast_weather_state.dart';

class WeekForeCastWeatherBloc
    extends Bloc<WeekForeCastWeatherEvent, WeekForeCastWeatherState> {
  WeatherService service;
  WeekForeCastWeatherBloc({required this.service})
      : super(WeekForeCastWeatherInitial()) {
    on<WeekForeCastWeatherRequested>((event, emit) async {
      emit(WeekForeCastWeatherLoadInProgress());
      try {
        final weekForeCastWeather = await service.getWeekForecast(
            lat: event.lat, lon: event.lon) as WeekForeCastWeather;
        emit(WeekForeCastWeatherLoadSuccess(
            weekForeCastWeather: weekForeCastWeather));
      } catch (error) {
        emit(WeekForeCastWeatherLoadFailure());
      }
    });
  }
}
