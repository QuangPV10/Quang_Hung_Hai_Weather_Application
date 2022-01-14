import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quang_hung_hai_weather_application/src/models/position.dart';

class CurrentWeather {
  final Position position;
  final String cityName;
  final String weatherCondition;
  final String temperature;
  late Uint8List? weatherConditionSymbol;

  set setWeatherConditionSymbol(Uint8List symbol) {
    weatherConditionSymbol = symbol;
  }

  CurrentWeather({
    required this.position,
    required this.cityName,
    required this.weatherCondition,
    required this.temperature,
    this.weatherConditionSymbol,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    String _temperature =
        ((json['main']['temp'] - 273.15) as num).toStringAsFixed(2);

    return CurrentWeather(
      position: Position(lat: json['coord']['lat'], lon: json['coord']['lon']),
      cityName: '${json['name']}',
      weatherCondition: '${json['weather'][0]['main']}',
      temperature: '$_temperature' + '\u00b0C',
      weatherConditionSymbol: json['weather_condition_symbol'],
    );
  }
}
