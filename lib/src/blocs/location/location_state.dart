import 'package:equatable/equatable.dart';

import '../../models/city.dart';

abstract class LocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoadInProgress extends LocationState {}

class LocationLoadFailure extends LocationState {
  final String errorMessage;

  LocationLoadFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class LocationLoadSuccess extends LocationState {
  final List<City> cities;

  LocationLoadSuccess({required this.cities});

  @override
  List<Object?> get props => [cities];
}
