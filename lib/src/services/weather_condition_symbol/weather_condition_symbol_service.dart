import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class WeatherConditionSymbolService {
  WeatherConditionSymbolService();

  Future<Uint8List> fetchSymbol({required String id});
}
