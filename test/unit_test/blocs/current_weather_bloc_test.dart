import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/models/current_weather.dart';
import 'package:quang_hung_hai_weather_application/src/models/temp_hourly.dart';
import 'package:quang_hung_hai_weather_application/src/models/weather.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather_service/weather_service.dart';
class MockWeatherService extends Mock implements WeatherService {}

void main() {
  WeatherService service ;
  CurrentWeatherBloc? currentWeatherBloc;
  double lat = 34.330502;
  double lon = 47.159401;

  Weather weather = Weather(weather: 'Clouds', weatherIcon: '01n');
  List<DayWeather> listTemp = [
    DayWeather(temp: 284.4, datetime: 1642040946, weather: weather),
    DayWeather(temp: 284.4, datetime: 1642040946, weather: weather)
  ];
  CurrentWeather currentWeather = CurrentWeather(
      dateTime: 1642040946,
      temp: 284.4,
      weatherStatus: weather,
      weatherHourlyAlerts: listTemp);

  blocTest(
    'emits [CurrentWeatherLoadInProgress] then [CurrentWeatherLoadSuccess] when [CurrentWeatherRequested] is called',
    build: () {
      service = MockWeatherService();
      when(service.getCurrentWeather(lon: lon, lat: lat))
          .thenAnswer((_) => Future.value(currentWeather));
      return CurrentWeatherBloc(service: service);
    },
    act: (CurrentWeatherBloc bloc) =>
        bloc.add(CurrentWeatherRequested(lon: lon, lat: lat)),
    expect: () => [
      CurrentWeatherLoadInProgress(),
      CurrentWeatherLoadSuccess(currentWeather: currentWeather)
    ],
  );

  blocTest(
    'emits [CurrentWeatherLoadInProgress] then [CurrentWeatherLoadFailure] when [CurrentWeatherRequested] is called',
    build: () {
      service = MockWeatherService();
      when(service.getCurrentWeather(lon: lon, lat: lat))
          .thenThrow(Exception());
      return CurrentWeatherBloc(service: service);
    },
    act: (CurrentWeatherBloc bloc) =>
        bloc.add(CurrentWeatherRequested(lon: lon, lat: lat)),
    expect: () => [CurrentWeatherLoadInProgress(), CurrentWeatherLoadFailure()],
  );
}
