import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_state.dart';
import 'package:quang_hung_hai_weather_application/src/models/city.dart';
import 'package:quang_hung_hai_weather_application/src/routes/route_controller.dart';
import 'package:quang_hung_hai_weather_application/src/screens/location_screen/location_screen.dart';
import 'package:quang_hung_hai_weather_application/src/widgets/load_fail_widget.dart';

import '../../common/common_mock.dart';
import '../../mock_data/location_data.dart';

void main() {
  final mockResponse = json.decode(mockLocationData);
  final mockObserver = MockNavigatorObserver();

  setUpAll(() {
    registerFallbackValue(FakeLocationState());
    registerFallbackValue(FakeLocationEvent());
    registerFallbackValue(RouteFake());
  });

  late LocationBloc locationBloc;

  var widget = BlocProvider(
    create: (context) => locationBloc,
    child: MaterialApp(
      onGenerateRoute: RouteController().routePage,
      home: const LocationScreen(cityName: 'Tokyo',),
    ),
  );

  setUp(() {
    locationBloc = MockLocationBloc();
  });

  tearDown(() {
    locationBloc.close();
  });

  final _cities =
      List<City>.from(mockResponse.map((model) => City.fromJson(model)));

  test('Should return a name of city', () {
    expect(LocationScreen.displayStringForOption(_cities.first),
        _cities.first.name);
  });

  testWidgets('Display Appbar', (WidgetTester tester) async {
    when(() => locationBloc.state)
        .thenReturn(LocationLoadSuccess(cities: _cities));
    await tester.pumpWidget(widget);
    final appbarFinder = find.byType(AppBar);
    expect(appbarFinder, findsOneWidget);
  });

  testWidgets('Navigator pop to WeatherForecastScreen', (tester) async {
    when(() => locationBloc.state)
        .thenReturn(LocationLoadSuccess(cities: _cities));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    final iconButtonFinder = find.byType(TextButton).first;
    expect(iconButtonFinder, findsOneWidget);
    await tester.tap(iconButtonFinder);
    await tester.pumpAndSettle();
    verifyNever(() => mockObserver.didPush(any(), any()));
  });

  testWidgets(
      'Should render orange container when crypto bloc state is [LocaitonInitial]',
      (tester) async {
    when(() => locationBloc.state).thenReturn(LocationInitial());
    await tester.pumpWidget(widget);
    await tester.pump();

    final orangeContainerFinder =
        (tester.widget(find.byType(Container)) as Container).color;

    expect(orangeContainerFinder, Colors.orange);
  });

  testWidgets('Should clear text in TextField when tap on x button',
      (tester) async {
    when(() => locationBloc.state)
        .thenReturn(LocationLoadSuccess(cities: _cities));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Container).first);
    await tester.enterText(find.byType(Container).first, 'q');
    await tester.pump(const Duration(seconds: 2));
    final textFinder = find.text('q');
    expect(textFinder, findsOneWidget);
    final iconButtonFinder = find.byType(IconButton);
    expect(iconButtonFinder, findsOneWidget);
    await tester.tap(iconButtonFinder);
    await tester.pumpAndSettle();
    expect(textFinder, findsNothing);
  });

  testWidgets('Should search city when bloc state is [LocationLoadSuccess]',
      (tester) async {
    when(() => locationBloc.state)
        .thenReturn(LocationLoadSuccess(cities: _cities));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Container).first);
    await tester.enterText(find.byType(Container).first, 'a');
    await tester.pump(const Duration(seconds: 2));
    final cityFinder = find.descendant(
        of: find.byType(ListView), matching: find.byType(ListTile).first);
    expect(cityFinder, findsOneWidget);
    await tester.tap(cityFinder);
    await tester.pumpAndSettle();
    verifyNever(() => mockObserver.didPush(any(), any()));
  });

  testWidgets(
      'Should render LoadFailure widget when search bloc state is [LocationLoadFailure]',
      (tester) async {
    when(() => locationBloc.state).thenReturn(LocationLoadFailure());
    await tester.pumpWidget(widget);
    await tester.pump();
    final errorMessageFinder = find.byType(LoadFailWidget);
    expect(errorMessageFinder, findsOneWidget);
  });

  testWidgets(
      'Should reload when tap on TextButton when bloc state is [LocationLoadFailure]',
      (tester) async {
    when(() => locationBloc.state).thenReturn(LocationLoadFailure());
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(LoadFailWidget));
    await tester.pump(const Duration(seconds: 2));
    final coinCardFinder = find.descendant(
        of: find.byType(Container), matching: find.byType(TextButton));
    expect(coinCardFinder, findsOneWidget);
    await tester.tap(coinCardFinder);
    await tester.pumpAndSettle();
    verifyNever(() => mockObserver.didPush(any(), any()));
  });
}
