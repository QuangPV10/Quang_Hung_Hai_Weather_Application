import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationRequested extends LocationEvent {}
