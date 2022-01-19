import 'package:flutter_simple_dependency_injection/injector.dart';

import '../blocs/current_weather_bloc/current_weather_bloc.dart';
import '../blocs/search_bloc/search_bloc.dart';
import '../blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import '../services/search_service/search_service.dart';
import '../services/weather_service/weather_service.dart';

class BlocsDependencies {
  static Injector initialise(Injector injector) {
    injector.map<WeekForeCastWeatherBloc>(
        (injector) =>
            WeekForeCastWeatherBloc(service: injector.get<WeatherService>()),isSingleton: true);
    injector.map<CurrentWeatherBloc>(
        (injector) =>
            CurrentWeatherBloc(service: injector.get<WeatherService>()  ),
        isSingleton: true);
    injector.map<SearchBloc>(
        (injector) => SearchBloc(service: injector.get<SearchService>()),
        isSingleton: true);
    return injector;
  }
}
