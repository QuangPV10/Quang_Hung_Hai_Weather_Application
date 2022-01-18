import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/search_bloc/search_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/search_bloc/search_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/search_bloc/search_state.dart';


import 'package:quang_hung_hai_weather_application/src/services/location/search_service.dart';

class MockSearchService extends Mock implements SearchService {}

main() {
  SearchService locationService;
  
  blocTest('emits [] when no event is added',
      build: () {
        locationService = MockSearchService();
        return SearchBloc(service: locationService);
      },
      expect: () => []);

  blocTest(
    'emits [LocationLoadInProgress] then [LocationLoadSucess] when [LocationRequested] is called',
    build: () {
      locationService = MockSearchService();
      when(locationService.fetchAllCity()).thenAnswer((_) async => []);
      return SearchBloc(service: locationService);
    },
    act: (SearchBloc bloc) => bloc.add(SearchRequested()),
    expect: () => [
      SearchLoadInProgress(),
      SearchLoadSuccess(cities: const []),
    ],
  );

  blocTest(
    'emits [LocationLoadFailure] when [LocationRequested] is called and service throws error.',
    build: () {
      locationService = MockSearchService();
      when(locationService.fetchAllCity()).thenThrow(Exception());
      return SearchBloc(service: locationService);
    },
    act: (SearchBloc bloc) => bloc.add(SearchRequested()),
    expect: () => [
      SearchLoadInProgress(),
      SearchLoadFailure(errorMessage: Exception().toString()),
    ],
  );
}
