import 'package:meta/meta.dart';

class RestaurantEntity {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final String currency;

  RestaurantEntity(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.description,
      @required this.price,
      @required this.currency});
}
