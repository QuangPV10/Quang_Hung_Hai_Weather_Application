import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/weather/weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/models/current_weather.dart';
import 'package:quang_hung_hai_weather_application/src/models/position.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather/weather_service.dart';

class MockWeatherService extends Mock implements WeatherService {}

main() {
  late WeatherService weatherService;

  late CurrentWeather fakeWeather;

  setUp(() {
    weatherService = MockWeatherService();
  });

  blocTest(
    'emits [] when no event is added',
    build: () {
      weatherService = MockWeatherService();
      return WeatherBloc(service: weatherService);
    },
    expect: () => [],
  );

  blocTest(
    'emits [WeatherLoadInProgress] then [WeatherLoadSucess] when [WeatherRequested] is called',
    build: () {
      fakeWeather = CurrentWeather(
          cityName: 'name',
          position: Position(lat: 1, lon: 1),
          temperature: '1',
          weatherCondition: 'condition');

      when(weatherService.fetchWeather(position: Position(lat: 1, lon: 1)))
          .thenAnswer(
        (_) async => fakeWeather,
      );

      return WeatherBloc(service: weatherService);
    },
    act: (WeatherBloc bloc) =>
        bloc.add(WeatherRequested(position: Position(lat: 1, lon: 1))),
    expect: () {
      return [
        WeatherLoadInProgress(),
        WeatherLoadSuccess(weather: fakeWeather),
      ];
    },
  );
}
