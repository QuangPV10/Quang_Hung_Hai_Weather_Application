import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/models/temp_daily.dart';
import 'package:quang_hung_hai_weather_application/src/models/weather.dart';
import 'package:quang_hung_hai_weather_application/src/models/week_forecast_weather.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather_service/weather_service.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  WeatherService service;
  WeekForeCastWeatherBloc? weekForeCastWeatherBloc;
  double lat = 34.330502;
  double lon = 47.159401;
  setUp(() {
    service = MockWeatherService();
    weekForeCastWeatherBloc = WeekForeCastWeatherBloc(service: service);
  });

  tearDown(() {
    weekForeCastWeatherBloc?.close();
  });
  Weather weather = Weather(weather: 'Clouds', weatherIcon: '01n');
  WeekWeather weekWeather = WeekWeather(
      tempMax: 284.4, tempMin: 284.4, dateTime: 1642040946, weather: weather);
  List<WeekWeather> listWeekWeather = [weekWeather, weekWeather, weekWeather];
  WeekForeCastWeather weekForeCastWeather =
      WeekForeCastWeather(listWeekWeather: listWeekWeather);

  blocTest(
    'emits [WeekForeCastWeatherLoadSuccess] then [CurrentWeatherLoadSuccess] when [WeekForeCastWeatherRequested] is called',
    build: () {
      service = MockWeatherService();
      when(service.getWeekForecast(lon: lon, lat: lat))
          .thenAnswer((_) => Future.value(weekForeCastWeather));
      return WeekForeCastWeatherBloc(service: service);
    },
    act: (WeekForeCastWeatherBloc bloc) =>
        bloc.add(WeekForeCastWeatherRequested(lon: lon, lat: lat)),
    expect: () => [
      WeekForeCastWeatherLoadInProgress(),
      WeekForeCastWeatherLoadSuccess(weekForeCastWeather: weekForeCastWeather)
    ],
  );

  blocTest(
    'emits [WeekForeCastWeatherLoadFailure] then [CurrentWeatherLoadFailure] when [WeekForeCastWeatherRequested] is called',
    build: () {
      service = MockWeatherService();

      when(service.getWeekForecast(lon: lon, lat: lat)).thenThrow(Exception());
      return WeekForeCastWeatherBloc(service: service);
    },
    act: (WeekForeCastWeatherBloc bloc) =>
        bloc.add(WeekForeCastWeatherRequested(lon: lon, lat: lat)),
    expect: () =>
        [WeekForeCastWeatherLoadInProgress(), WeekForeCastWeatherLoadFailure()],
  );
}
