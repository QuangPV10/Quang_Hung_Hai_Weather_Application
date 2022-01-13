import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_state.dart';

class FakeWeekForeCastWeatherState extends Fake
    implements WeekForeCastWeatherState {}

class FakeWeekForeCastWeatherEvent extends Fake
    implements WeekForeCastWeatherEvent {}

class FakeWeekForeCastWeatherBloc
    extends MockBloc<WeekForeCastWeatherEvent, WeekForeCastWeatherState>
    implements WeekForeCastWeatherBloc {}
