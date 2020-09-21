part of 'home_details_bloc.dart';

class HomeDetailsState extends Equatable {
  final RestaurantEntity entity;
  final int quantity;
  final bool isLiked;

  const HomeDetailsState(
      {this.entity, this.quantity = 1, this.isLiked = false});

  HomeDetailsState copyWith(
          {RestaurantEntity entity, int quantity, bool isLiked}) =>
      HomeDetailsState(
        entity: entity ?? this.entity,
        isLiked: isLiked ?? this.isLiked,
        quantity: quantity ?? this.quantity,
      );

  @override
  List<Object> get props => [isLiked, quantity, entity];
}
