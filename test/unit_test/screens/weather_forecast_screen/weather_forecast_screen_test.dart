import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/current_weather_bloc/current_weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/week_forecast_weather_bloc/week_forecast_weather_state.dart';
import 'package:quang_hung_hai_weather_application/src/models/city.dart';
import 'package:quang_hung_hai_weather_application/src/models/current_weather.dart';
import 'package:quang_hung_hai_weather_application/src/models/temp_daily.dart';
import 'package:quang_hung_hai_weather_application/src/models/temp_hourly.dart';
import 'package:quang_hung_hai_weather_application/src/models/weather.dart';
import 'package:quang_hung_hai_weather_application/src/models/week_forecast_weather.dart';
import 'package:quang_hung_hai_weather_application/src/routes/route_controller.dart';
import 'package:quang_hung_hai_weather_application/src/screens/weather_forecast_screen/weather_forecast_screen.dart';
import 'package:quang_hung_hai_weather_application/src/services/weather_service/weather_service.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/load_fail_widget.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/map.dart';

import '../../../mock_data/curent_weather_bloc_fake.dart';
import '../../../mock_data/week_weather_forecast_bloc_fake.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockWeatherService extends Mock implements WeatherService {}

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

main() {
  CustomBindings();

  setUpAll(() {
    registerFallbackValue(RouteFake());
  });

  group('Weather Forecast Screen Tests', () {
    String cityName = "Ha Tinh";
    double lat = 34.330502;
    double lon = 47.159401;
    City city = City( name: cityName, latitude: lat,longitude: lon);

    late WeatherService service = MockWeatherService();
    late CurrentWeatherBloc currentWeatherBloc =
        CurrentWeatherBloc(service: service);
    late WeekForeCastWeatherBloc weekForeCastWeatherBloc =
        WeekForeCastWeatherBloc(service: service);

    final mockObserver = MockNavigatorObserver();
    Weather weather = Weather(weather: 'Clouds', weatherIcon: '01n');
    List<DayWeather> listTemp = [
      DayWeather(temp: 284.4, datetime: 1642040946, weather: weather),
      DayWeather(temp: 284.4, datetime: 1642040946, weather: weather)
    ];

    CurrentWeather currentWeather = CurrentWeather(
        dateTime: 1642040946,
        temp: 284.4,
        weatherStatus: weather,
        weatherHourlyAlerts: listTemp);
    WeekWeather weekWeather = WeekWeather(
        tempMax: 284.4, tempMin: 284.4, dateTime: 1642040946, weather: weather);
    List<WeekWeather> listWeekWeather = [weekWeather, weekWeather, weekWeather];
    WeekForeCastWeather weekForeCastWeather =
        WeekForeCastWeather(listWeekWeather: listWeekWeather);

    var widget = MaterialApp(
      navigatorObservers: [mockObserver],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteController().routePage,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => currentWeatherBloc),
          BlocProvider(create: (context) => weekForeCastWeatherBloc),
        ],
        child: WeatherForecastScreen(
          city: city,
        ),
      ),
    );

    testWidgets('Should render AppBar when WeatherForeCast Screen displayed',
        (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);
    });

    testWidgets('Display MapWidget when state is CurrentWeatherLoadSuccess',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(find.byType(MapWidget).first, findsOneWidget);
    });

    testWidgets(
        'Display CircularProgressIndicator when state is CurrentWeatherLoadInProgress',
        (WidgetTester tester) async {
      currentWeatherBloc = FakeCurrentWeatherBloc();
      when(() => currentWeatherBloc.state)
          .thenReturn(CurrentWeatherLoadInProgress());
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.pump();
      expect(find.byType(CircularProgressIndicator).first, findsOneWidget);
    });

    testWidgets('Display Degrees when state is CurrentWeatherLoadSuccess',
        (WidgetTester tester) async {
      currentWeatherBloc = FakeCurrentWeatherBloc();
      weekForeCastWeatherBloc = FakeWeekForeCastWeatherBloc();
      when(() => currentWeatherBloc.state).thenReturn(
          CurrentWeatherLoadSuccess(currentWeather: currentWeather));
      when(() => weekForeCastWeatherBloc.state).thenReturn(
          WeekForeCastWeatherLoadSuccess(
              weekForeCastWeather: weekForeCastWeather));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });

    testWidgets('Display RefreshButton when state is CurrentWeatherLoadFailure',
        (WidgetTester tester) async {
      currentWeatherBloc = FakeCurrentWeatherBloc();
      when(() => currentWeatherBloc.state)
          .thenReturn(CurrentWeatherLoadFailure());
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.pump();
      var refreshButton = find.byType(LoadFailWidget).first;
      expect(refreshButton, findsOneWidget);
      await tester.tap(refreshButton);
      verify(() =>
          currentWeatherBloc.add(CurrentWeatherRequested(lat: lat, lon: lon)));
    });

    testWidgets(
        'Display RefreshButton when state is WeekForeCastWeatherLoadFailure',
        (WidgetTester tester) async {
      weekForeCastWeatherBloc = FakeWeekForeCastWeatherBloc();
      when(() => weekForeCastWeatherBloc.state)
          .thenReturn(WeekForeCastWeatherLoadFailure());
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.pump();
      var refreshButton = find.byType(LoadFailWidget).last;
      expect(refreshButton, findsOneWidget);
      await tester.tap(refreshButton);
      verify(() => weekForeCastWeatherBloc
          .add(WeekForeCastWeatherRequested(lat: lat, lon: lon)));
    });
  });
}
