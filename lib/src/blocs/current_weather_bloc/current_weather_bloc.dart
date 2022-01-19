import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../services/current_location_service/current_location_service_impl.dart';
import '../../models/current_weather.dart';
import '../../services/weather_service/weather_service.dart';
import 'current_weather_event.dart';
import 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  WeatherService service;

  CurrentWeatherBloc({required this.service}) : super(CurrentWeatherInitial()) {
    on<CurrentWeatherRequested>((event, emit) async {
      try {
        emit(CurrentWeatherLoadInProgress());

        double _lat;
        double _lon;

        if (event.requireCurrentLocation!) {
          final _currentLocationGetter = CurrentLocationServiceImpl();
          final LocationData _locationData =
              await _currentLocationGetter.getCurrentLocation();
          _lat = _locationData.latitude!;
          _lon = _locationData.longitude!;
        } else {
          _lat = event.lat;
          _lon = event.lon;
        }

        final currentWeather = await service.getCurrentWeather(
            lon: _lon, lat: _lat) as CurrentWeather;
        emit(CurrentWeatherLoadSuccess(currentWeather: currentWeather));
      } catch (error) {
        emit(CurrentWeatherLoadFailure());
      }
    });
  }
}
