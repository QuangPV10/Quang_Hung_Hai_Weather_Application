import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_state.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class FakeLocationState extends Fake implements LocationState {}

class FakeLocationEvent extends Fake implements LocationEvent {}

class RouteFake extends Fake implements Route {}
