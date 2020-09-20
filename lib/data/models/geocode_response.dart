import 'package:json_annotation/json_annotation.dart';

part 'geocode_response.g.dart';

@JsonSerializable()
class GeocodeResponse {
  @JsonKey(name: "nearby_restaurants")
  final List<RestaurantResponseModel> nearbyRestaurants;
  final PopularityModel popularity;

  GeocodeResponse(this.nearbyRestaurants, this.popularity);

  factory GeocodeResponse.fromJson(Map<String, dynamic> json) =>
      _$GeocodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodeResponseToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}

@JsonSerializable()
class RestaurantResponseModel {
  final RestaurantModel restaurant;

  RestaurantResponseModel(this.restaurant);

  factory RestaurantResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantResponseModelToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  final String url;
  @JsonKey(name: "average_cost_for_two")
  final int averageCostForTwo;
  final String currency;
  @JsonKey(name: "featured_image")
  final String featuredImage;
  final String cuisines;

  RestaurantModel(this.id, this.name, this.url, this.averageCostForTwo,
      this.currency, this.featuredImage, this.cuisines);

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}

@JsonSerializable()
class PopularityModel {
  @JsonKey(name: "nearby_res")
  final List<String> nearbyRestaurants;
  @JsonKey(name: "top_cuisines")
  final List<String> topCuisines;

  PopularityModel(this.nearbyRestaurants, this.topCuisines);

  factory PopularityModel.fromJson(Map<String, dynamic> json) =>
      _$PopularityModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularityModelToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}
