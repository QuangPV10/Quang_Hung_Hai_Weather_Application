import 'package:http/http.dart' as http;
import 'package:quang_hung_hai_weather_application/src/models/current_weather.dart';
import 'package:quang_hung_hai_weather_application/src/models/position.dart';

abstract class WeatherService {
  WeatherService();

  Future<CurrentWeather>? fetchWeather({required Position position});
}
