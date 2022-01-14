import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../config/constants.dart';
import '../../models/current_weather.dart';
import '../../models/week_forecast_weather.dart';
import 'weather_service.dart';

class WeatherServiceImpl extends WeatherService {
  @override
  Future<CurrentWeather> getCurrentWeather(
      {required double lon, required double lat}) async {
    var url = Uri.parse(AppConfig.instance.getValue(AppConstants.HOST_NAME) +
        AppConfig.instance.getValue(AppConstants.VERSION_2) +
        AppConfig.instance.getValue(AppConstants.ONE_CALL_PATH) +
        AppConfig.instance.getValue(AppConstants.LAT) +
        lat.toString() +
        AppConfig.instance.getValue(AppConstants.LON) +
        lon.toString() +
        AppConfig.instance.getValue(AppConstants.EXCLUDE) +
        AppConfig.instance.getValue(AppConstants.ALERT_PATH) +
        AppConfig.instance.getValue(AppConstants.KEY));

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      CurrentWeather currentWeather = CurrentWeather.fromJson(responseData);
      return currentWeather;
    } else {
      throw Exception();
    }
  }

  @override
  Future<WeekForeCastWeather> getWeekForecast(
      {required double lon, required double lat}) async {
    var url = Uri.parse(AppConfig.instance.getValue(AppConstants.HOST_NAME) +
        AppConfig.instance.getValue(AppConstants.VERSION_2) +
        AppConfig.instance.getValue(AppConstants.ONE_CALL_PATH) +
        AppConfig.instance.getValue(AppConstants.LAT) +
        lat.toString() +
        AppConfig.instance.getValue(AppConstants.LON) +
        lon.toString() +
        AppConfig.instance.getValue(AppConstants.EXCLUDE) +
        AppConfig.instance.getValue(AppConstants.ALERT_PATH) +
        AppConfig.instance.getValue(AppConstants.KEY));
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final currentWeather = json.decode(response.body);
      return WeekForeCastWeather.fromJson(currentWeather);
    } else {
      throw Exception();
    }
  }
}
