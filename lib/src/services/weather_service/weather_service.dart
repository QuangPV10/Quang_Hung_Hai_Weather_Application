import '../../models/current_weather.dart';
import '../../models/week_forecast_weather.dart';

abstract class WeatherService {
  Future<CurrentWeather>? getCurrentWeather(
      {required double lon, required double lat});
  Future<WeekForeCastWeather>? getWeekForecast(
      {required double lon, required double lat});
}
