// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocode_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodeResponse _$GeocodeResponseFromJson(Map<String, dynamic> json) {
  return GeocodeResponse(
    (json['nearby_restaurants'] as List)
        ?.map((e) => e == null
            ? null
            : RestaurantResponseModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['popularity'] == null
        ? null
        : PopularityModel.fromJson(json['popularity'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeocodeResponseToJson(GeocodeResponse instance) =>
    <String, dynamic>{
      'nearby_restaurants': instance.nearbyRestaurants,
      'popularity': instance.popularity,
    };

RestaurantResponseModel _$RestaurantResponseModelFromJson(
    Map<String, dynamic> json) {
  return RestaurantResponseModel(
    json['restaurant'] == null
        ? null
        : RestaurantModel.fromJson(json['restaurant'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RestaurantResponseModelToJson(
        RestaurantResponseModel instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant,
    };

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) {
  return RestaurantModel(
    json['id'] as String,
    json['name'] as String,
    json['url'] as String,
    json['average_cost_for_two'] as int,
    json['currency'] as String,
    json['featured_image'] as String,
    json['cuisines'] as String,
  );
}

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'average_cost_for_two': instance.averageCostForTwo,
      'currency': instance.currency,
      'featured_image': instance.featuredImage,
      'cuisines': instance.cuisines,
    };

PopularityModel _$PopularityModelFromJson(Map<String, dynamic> json) {
  return PopularityModel(
    (json['nearby_res'] as List)?.map((e) => e as String)?.toList(),
    (json['top_cuisines'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PopularityModelToJson(PopularityModel instance) =>
    <String, dynamic>{
      'nearby_res': instance.nearbyRestaurants,
      'top_cuisines': instance.topCuisines,
    };
