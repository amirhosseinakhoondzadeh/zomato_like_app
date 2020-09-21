import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zomato_like_app/core/error/failures.dart';
import 'package:zomato_like_app/data/models/geocode_response.dart';
import 'package:zomato_like_app/data/repository.dart';
import 'package:zomato_like_app/entities/restaurant_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GeolocatorPlatform _geolocator;
  final Repository _repository;

  HomeBloc(
      {@required GeolocatorPlatform geolocatorPlatform,
      @required Repository repository})
      : assert(geolocatorPlatform != null),
        assert(repository != null),
        _repository = repository,
        _geolocator = geolocatorPlatform,
        super(HomeState());

  StreamSubscription _locationSubscription;

  List<RestaurantEntity> allNearbyRestaurants;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeInitialized) {
      yield HomeState.loading();
      _locationSubscription?.cancel();

      // We Update location every 2km
      _locationSubscription = _geolocator
          .getPositionStream(
              desiredAccuracy: LocationAccuracy.high, distanceFilter: 2000)
          .listen(
            (Position position) => add(
              LocationChanged(position: position),
            ),
          );
    } else if (event is LocationChanged) {
      add(LoadRestaurantsByCoordinates(position: event.position));
    } else if (event is LoadRestaurantsByCoordinates) {
      yield* _mapLoadRestaurantsByCoordinatesToState(event, state);
    } else if (event is ChangeCuisine) {
      final selectedCuisine = state.cuisines[event.index];
      // todo : Handle popular as well
      yield state.copyWith(
        selectedCuisine: selectedCuisine,
        nearbyRestaurants: allNearbyRestaurants
            .where((element) => element.description.contains(selectedCuisine))
            .toList(),
      );
    }
  }

  Stream<HomeState> _mapLoadRestaurantsByCoordinatesToState(
      LoadRestaurantsByCoordinates event, HomeState state) async* {
    final currentState = state;
    yield HomeState.loading();

    final failureOrLoaded =
        await _repository.fetchNearbyRestaurantsByCoordinates(
            lat: event.position.latitude, lon: event.position.longitude);
    yield* _eitherLoadedOrErrorState(failureOrLoaded, currentState);
  }

  Stream<HomeState> _eitherLoadedOrErrorState(
    Either<Failure, GeocodeResponse> failureOrLogin,
    HomeState currentState,
  ) async* {
    yield failureOrLogin.fold(
      (failure) =>
          HomeState.failure(previousState: state, failure: failure.message),
      (geoResponse) => _processSuccessResult(geoResponse, currentState),
    );
  }

  @override
  Future<Function> close() {
    _locationSubscription.cancel();
    return super.close();
  }

  HomeState _processSuccessResult(
      GeocodeResponse geoResponse, HomeState state) {
    final cuisines = geoResponse?.popularity?.topCuisines ?? <String>["All"];
    final selectedCuisines = cuisines?.first ?? "All";

    // Create the main nearby list
    allNearbyRestaurants = geoResponse.nearbyRestaurants
        .map(
          (e) => RestaurantEntity(
              name: e.restaurant.name ?? "",
              description: e.restaurant.cuisines ?? "",
              id: e.restaurant.id,
              price: e.restaurant.averageCostForTwo.toDouble(),
              currency: e.restaurant.currency,
              imageUrl: e.restaurant.featuredImage),
        )
        .toList();

    // Create Filtered nearby list
    final nearbyRestaurants = allNearbyRestaurants
        .where((element) => element.description.contains(selectedCuisines))
        .toList();

    // Create a duplicate of nearByList as Popular since the api does not return the list
    final popularRestaurants = geoResponse.nearbyRestaurants
        .map(
          (e) => RestaurantEntity(
              name: e.restaurant.name ?? "",
              description: e.restaurant.cuisines ?? "",
              id: e.restaurant.id,
              price: e.restaurant.averageCostForTwo.toDouble(),
              currency: e.restaurant.currency,
              imageUrl: e.restaurant.featuredImage),
        )
        .toList();

    return HomeState.loaded(
      position: state.position,
      cuisines: cuisines,
      nearbyRestaurants: nearbyRestaurants,
      popularRestaurants: popularRestaurants,
      selectedCuisine: selectedCuisines,
    );
  }
}
