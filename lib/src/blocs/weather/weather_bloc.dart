import 'package:bloc/bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/models/current_weather.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather/weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService service;
  WeatherBloc({required this.service}) : super(WeatherInitial()) {
    on<WeatherRequested>((event, emit) async {
      try {
        CurrentWeather _weather;

        emit(WeatherLoadInProgress());
        _weather = await service.fetchWeather(position: event.position);
        emit(WeatherLoadSuccess(weather: _weather));
      } catch (e) {
        emit(WeatherLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
