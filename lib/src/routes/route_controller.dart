import 'package:flutter/material.dart';
import 'package:quang_hung_hai_weather_application/src/screens/location_screen/location_screen.dart';
import 'package:quang_hung_hai_weather_application/src/screens/main_screen/main_screen.dart';
import 'package:quang_hung_hai_weather_application/src/screens/not_found_screen/not_found_screen.dart';
import 'package:quang_hung_hai_weather_application/src/screens/weather_forecast_screen/weather_forecast_screen.dart';

import '../constants/routes_name.dart';

class RouteController {
  MaterialPageRoute routePage(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) {
        switch (settings.name) {
          case RouteNames.main:
            return const MainScreen();
          case RouteNames.location:
            return const LocationScreen();
          case RouteNames.weatherForecast:
            return WeatherForecastScreen(settings.arguments as String);
          default:
            return const NotFoundScreen();
        }
      },
      settings: settings,
    );
  }
}
