import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_bloc.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_event.dart';
import 'package:quang_hung_hai_weather_application/src/blocs/location/location_state.dart';
import 'package:quang_hung_hai_weather_application/src/services/location/location_service.dart';

class MockLocationService extends Mock implements LocationService {}

main() {
  LocationService locationService;
  
  blocTest('emits [] when no event is added',
      build: () {
        locationService = MockLocationService();
        return LocationBloc(service: locationService);
      },
      expect: () => []);

  blocTest(
    'emits [LocationLoadInProgress] then [LocationLoadSucess] when [LocationRequested] is called',
    build: () {
      locationService = MockLocationService();
      when(locationService.fetchCity()).thenAnswer((_) async => []);
      return LocationBloc(service: locationService);
    },
    act: (LocationBloc bloc) => bloc.add(LocationRequested()),
    expect: () => [
      LocationLoadInProgress(),
      LocationLoadSuccess(cities: const []),
    ],
  );

  blocTest(
    'emits [LocationLoadFailure] when [LocationRequested] is called and service throws error.',
    build: () {
      locationService = MockLocationService();
      when(locationService.fetchCity()).thenThrow(Exception());
      return LocationBloc(service: locationService);
    },
    act: (LocationBloc bloc) => bloc.add(LocationRequested()),
    expect: () => [
      LocationLoadInProgress(),
      LocationLoadFailure(errorMessage: Exception().toString()),
    ],
  );
}
