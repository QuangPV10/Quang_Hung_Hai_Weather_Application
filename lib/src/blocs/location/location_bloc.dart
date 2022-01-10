import 'package:bloc/bloc.dart';

import '../../services/location/location_service.dart';
import './location_event.dart';
import './location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService service;

  LocationBloc({required this.service}) : super(LocationInitial()) {
    on<LocationRequested>((event, emit) async {
      try {
        emit(LocationLoadInProgress());
        final cities = await service.fetchCity();
        emit(LocationLoadSuccess(cities: cities));
      } catch (e) {
        emit(LocationLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
