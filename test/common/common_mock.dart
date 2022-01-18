import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/search_bloc/search_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/search_bloc/search_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/search_bloc/search_state.dart';



class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockLocationBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class FakeSearchState extends Fake implements SearchState {}

class FakeSearchEvent extends Fake implements SearchEvent {}

class RouteFake extends Fake implements Route {}
