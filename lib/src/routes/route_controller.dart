import 'package:flutter/material.dart';
import '../screens/location_screen/location_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/not_found_screen/not_found_screen.dart';
import '../screens/weather_forecast_screen/weather_forecast_screen.dart';

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
            final city = settings.arguments as String;
            final lon = settings.arguments as double;
            final lat = settings.arguments as double;
            return WeatherForecastScreen(
              city: city,
              lon: lon,
              lat: lat,
            );
          default:
            return const NotFoundScreen();
        }
      },
      settings: settings,
    );
  }
}
