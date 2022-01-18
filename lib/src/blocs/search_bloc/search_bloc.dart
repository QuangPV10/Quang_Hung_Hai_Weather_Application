import 'package:bloc/bloc.dart';

import '../../services/search_service/search_service.dart';
import './search_event.dart';
import './search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService service;

  SearchBloc({required this.service}) : super(SearchInitial()) {
    on<SearchRequested>((event, emit) async {
      emit(SearchLoadInProgress());
      try {
        final cities = await service.fetchAllCity();
        emit(SearchLoadSuccess(cities: cities!));
      } catch (e) {
        emit(SearchLoadFailure(errorMessage: e.toString()));
      }
    });
  }
}
