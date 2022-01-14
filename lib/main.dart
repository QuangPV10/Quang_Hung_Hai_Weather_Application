import 'package:flutter/material.dart';
import 'package:quang_hung_hai_weather_application/src/config/app_config.dart';

import './src/app.dart';

void main() async {
  await AppConfig().initialize();
  runApp(const MyApp());
}
