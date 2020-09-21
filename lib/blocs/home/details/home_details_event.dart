part of 'home_details_bloc.dart';

abstract class HomeDetailsEvent extends Equatable {
  const HomeDetailsEvent();
  @override
  List<Object> get props => [];
}

class HomeDetailsInitialized extends HomeDetailsEvent {
  final RestaurantEntity entity;
  const HomeDetailsInitialized({@required this.entity});
  @override
  List<Object> get props => [entity];
}
class IncrementQuantity extends HomeDetailsEvent {}
class DecrementQuantity extends HomeDetailsEvent {}
class LikeChanged extends HomeDetailsEvent {}


