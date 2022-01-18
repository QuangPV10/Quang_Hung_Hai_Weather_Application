import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/current_weather_bloc/current_weather_bloc.dart';
import './blocs/location/location_bloc.dart';
import './blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import './constants/routes_name.dart';
import './routes/route_controller.dart';
import './services/location/location_impl.dart';
import './services/weather_service/weather_service_impl.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationImpl _locationImpl = LocationImpl();
    return MaterialApp(
      initialRoute: RouteNames.main,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteController().routePage,
    );
  }
}
