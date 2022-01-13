import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_state.dart';

class FakeCurrentWeatherState extends Fake implements CurrentWeatherState {}

class FakeCurrentWeatherEvent extends Fake implements CurrentWeatherEvent {}

class FakeCurrentWeatherBloc
    extends MockBloc<CurrentWeatherEvent, CurrentWeatherState>
    implements CurrentWeatherBloc {}

class RouteFake extends Fake implements Route {}
