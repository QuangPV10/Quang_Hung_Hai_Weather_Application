import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/current_weather_bloc/current_weather_bloc.dart';
import './blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import './routes/route_controller.dart';
import './screens/weather_forecast_screen/weather_forecast_screen.dart';
import './services/weather_service/weather_service_impl.dart';
import './blocs/location/location_bloc.dart';
import './constants/routes_name.dart';
import './routes/route_controller.dart';
import './services/location/location_impl.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final WeatherServiceImpl;
    final LocationImpl _locationImpl = LocationImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CurrentWeatherBloc(service: WeatherServiceImpl())),
        BlocProvider(
            create: (context) =>
                WeekForeCastWeatherBloc(service: WeatherServiceImpl())),
         BlocProvider(
          create: (context) => LocationBloc(service: _locationImpl),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteController().routePage,
        home: const WeatherForecastScreen(
            lat: 34.330502, lon: 47.159401, city: "Ha Tinh"),
      ),
    );
  }
}
