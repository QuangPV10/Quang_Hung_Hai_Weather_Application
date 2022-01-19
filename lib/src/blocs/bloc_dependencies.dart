import 'package:flutter_simple_dependency_injection/injector.dart';

import '../services/search_service/search_service.dart';
import '../services/weather_service/weather_service.dart';
import './current_weather_bloc/current_weather_bloc.dart';
import './search_bloc/search_bloc.dart';
import './week_forecast_weather_bloc/week_forecast_weather_bloc.dart';

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
