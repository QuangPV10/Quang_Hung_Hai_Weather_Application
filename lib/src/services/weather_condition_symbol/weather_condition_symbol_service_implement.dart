import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quang_hung_hai_weather_application/src/config/app_config.dart';
import 'package:quang_hung_hai_weather_application/src/config/constant.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather_condition_symbol/weather_condition_symbol_service.dart';
import 'package:http/http.dart' as http;

class WeatherConditionSymbolServiceImplement
    extends WeatherConditionSymbolService {
  @override
  Future<Uint8List> fetchSymbol({required String id}) async {
    final uri = Uri(
      scheme: 'https',
      host: 'openweathermap.org',
      path: AppConfig.instance
              .getValue(AppConstants.WEATHER_CONDITION_SYMBOL_PATH) +
          '/$id@2x.png',
    );

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Uint8List symbol;
      symbol = response.bodyBytes;
      return symbol;
    } else {
      throw Exception('Failed to load symbol');
    }
  }
}
