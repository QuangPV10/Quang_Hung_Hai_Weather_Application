import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:quang_hung_hai_weather_application/src/services/location/search_impl.dart';
import 'package:quang_hung_hai_weather_application/src/services/location/search_service.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather_service/weather_service.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather_service/weather_service_impl.dart';

class ServicesDependencies {
  static Injector initialise(Injector injector) {
    injector.map<WeatherService>((injector) => WeatherServiceImpl());
    injector.map<SearchService>((injector) => SearchImpl());
    return injector;
  }
}