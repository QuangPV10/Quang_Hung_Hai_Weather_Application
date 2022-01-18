import 'package:equatable/equatable.dart';

import '../../models/city.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadInProgress extends SearchState {}

class SearchLoadFailure extends SearchState {
  final String? errorMessage;

  SearchLoadFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class SearchLoadSuccess extends SearchState {
  final List<City> cities;

  SearchLoadSuccess({required this.cities});

  @override
  List<Object?> get props => [cities];
}
