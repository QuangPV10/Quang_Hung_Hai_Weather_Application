import 'package:flutter_simple_dependency_injection/injector.dart';

import './search_service/search_service_impl.dart';
import './search_service/search_service.dart';
import './weather_service/weather_service.dart';
import './weather_service/weather_service_impl.dart';

class ServicesDependencies {
  static Injector initialise(Injector injector) {
    injector.map<WeatherService>((injector) => WeatherServiceImpl());
    injector.map<SearchService>((injector) => SearchServiceImpl());
    return injector;
  }
}