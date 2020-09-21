import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zomato_like_app/entities/restaurant_entity.dart';

part 'home_details_event.dart';
part 'home_details_state.dart';

class HomeDetailsBloc extends Bloc<HomeDetailsEvent, HomeDetailsState> {
  HomeDetailsBloc() : super(HomeDetailsState());

  @override
  Stream<HomeDetailsState> mapEventToState(
    HomeDetailsEvent event,
  ) async* {
    if (event is HomeDetailsInitialized) {
      print("initialized called");
      yield state.copyWith(entity: event.entity);
    } else if (event is IncrementQuantity) {
      final qty = state.quantity;
      yield state.copyWith(quantity: qty + 1);
    } else if (event is DecrementQuantity) {
      final qty = state.quantity;
      if (qty == 1) return;
      yield state.copyWith(quantity: qty - 1);
    } else if (event is LikeChanged) {
      final liked = state.isLiked;
      yield state.copyWith(isLiked: !liked);
    }
  }
}
