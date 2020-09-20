part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class HomeInitialized extends HomeEvent {}

class LocationChanged extends HomeEvent {
  final Position position;
  const LocationChanged({@required this.position});
  @override
  List<Object> get props => [position];
}

class LoadRestaurantsByCoordinates extends HomeEvent {
  final Position position;
  const LoadRestaurantsByCoordinates({@required this.position});
  @override
  List<Object> get props => [position];
}

class ChangeCuisine extends HomeEvent {
  final int index;
  const ChangeCuisine({@required this.index});
  @override
  List<Object> get props => [index];
}
