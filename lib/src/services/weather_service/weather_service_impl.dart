import 'dart:convert';

import 'package:quang_hung_hai_weather_application/src/utilities/rest_client.dart';
import '../../models/current_weather.dart';
import '../../models/week_forecast_weather.dart';
import './weather_service.dart';

class WeatherServiceImpl extends WeatherService {
  @override
  Future<CurrentWeather> getCurrentWeather(
      {required double lon, required double lat}) async {
    final currentWeatherBody = await HttpClientServices.httpClient().getData(
        '/data/2.5/onecall',
        params: {"lat": '$lat', "lon": '$lon', "exclude": "alerts"});
    final responseData = json.decode(currentWeatherBody);
    CurrentWeather currentWeather = CurrentWeather.fromJson(responseData);
    return currentWeather;
  }

  @override
  Future<WeekForeCastWeather> getWeekForecast(
      {required double lon, required double lat}) async {
    final weekWeatherBody = await HttpClientServices.httpClient().getData(
        '/data/2.5/onecall',
        params: {"lat": '$lat', "lon": '$lon', "exclude": "alerts"});
    final responseData = json.decode(weekWeatherBody);

    return WeekForeCastWeather.fromJson(responseData);
  }
}
