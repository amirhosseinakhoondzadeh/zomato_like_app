part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final bool isLoading;
  final Position position;
  final List<String> cuisines;
  final String selectedCuisine;
  final List<RestaurantEntity> nearbyRestaurants;
  final List<RestaurantEntity> popularRestaurants;
  final String failure;
  final bool isFailure;

  const HomeState(
      {this.isLoading = false,
      this.position,
      this.cuisines = const <String>[],
      this.nearbyRestaurants = const <RestaurantEntity>[],
      this.popularRestaurants = const <RestaurantEntity>[],
      this.selectedCuisine,
      this.failure,
      this.isFailure});

  factory HomeState.loading() => HomeState(isLoading: true);

  factory HomeState.fetchedCurrentLocation({@required Position position}) =>
      HomeState(isLoading: false, position: position);

  factory HomeState.loaded({
    @required String selectedCuisine,
    @required Position position,
    @required List<String> cuisines,
    @required List<RestaurantEntity> nearbyRestaurants,
    @required List<RestaurantEntity> popularRestaurants,
  }) =>
      HomeState(
          position: position,
          isLoading: false,
          cuisines: cuisines,
          nearbyRestaurants: nearbyRestaurants,
          popularRestaurants: popularRestaurants,
          selectedCuisine: selectedCuisine);

  factory HomeState.failure({
    @required HomeState previousState,
    @required String failure,
  }) =>
      HomeState(
        position: previousState.position,
        isLoading: false,
        cuisines: previousState.cuisines,
        nearbyRestaurants: previousState.nearbyRestaurants,
        popularRestaurants: previousState.popularRestaurants,
        selectedCuisine: previousState.selectedCuisine,
        isFailure: true,
        failure: failure,
      );

  HomeState copyWith({
    String selectedCuisine,
    List<RestaurantEntity> nearbyRestaurants,
    List<RestaurantEntity> popularRestaurants,
  }) =>
      HomeState(
        selectedCuisine: selectedCuisine ?? this.selectedCuisine,
        failure: null,
        isFailure: false,
        popularRestaurants: popularRestaurants ?? this.popularRestaurants,
        nearbyRestaurants: nearbyRestaurants ?? this.popularRestaurants,
        cuisines: this.cuisines,
        isLoading: false,
        position: this.position,
      );

  @override
  List<Object> get props => [
        isLoading,
        position,
        failure,
        isFailure,
        selectedCuisine,
        nearbyRestaurants,
        popularRestaurants,
        cuisines,
      ];
}
