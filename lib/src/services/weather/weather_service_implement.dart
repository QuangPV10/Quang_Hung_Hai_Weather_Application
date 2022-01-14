import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/src/client.dart';
import 'package:quang_hung_hai_weather_application/src/config/app_config.dart';
import 'package:quang_hung_hai_weather_application/src/config/constant.dart';
import 'package:quang_hung_hai_weather_application/src/models/current_weather.dart';
import 'package:quang_hung_hai_weather_application/src/models/position.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather/weather_service.dart';
import 'package:http/http.dart' as http;
import 'package:quang_hung_hai_weather_application/src/services/weather_condition_symbol/weather_condition_symbol_service_implement.dart';

class WeatherServiceImplement extends WeatherService {
  @override
  Future<CurrentWeather> fetchWeather({required Position position}) async {
    WeatherConditionSymbolServiceImplement symbolService =
        WeatherConditionSymbolServiceImplement();

    Map<String, String> queryParams = {
      'lat': '${position.lat}',
      'lon': '${position.lon}',
      'appid': '3ed0ef21dd370431bc47b7f67e06aca3',
    };

    final uri = Uri(
      scheme: 'https',
      host: AppConfig.instance.getValue(AppConstants.HOST_NAME),
      path: AppConfig.instance.getValue(AppConstants.WEATHER_PATH),
      queryParameters: queryParams,
    );

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> weatherJson = json.decode(response.body);

      CurrentWeather weather = CurrentWeather.fromJson(weatherJson);
      weather.position.setZoom = position.zoom ?? 1;

      Uint8List symbol = await symbolService.fetchSymbol(
          id: weatherJson['weather'][0]['icon']);

      weather.setWeatherConditionSymbol = symbol;

      return weather;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
