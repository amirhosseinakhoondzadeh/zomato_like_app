import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:zomato_like_app/core/constants/keys.dart';
import 'package:zomato_like_app/core/error/exceptions.dart';
import 'package:zomato_like_app/core/helpers/print_wrapper.dart';
import 'package:zomato_like_app/data/models/geocode_response.dart';

abstract class RemoteDataSource {
  Future<GeocodeResponse> fetchNearbyRestaurantsByCoordinates(
      {@required double lat, @required double lon});
  Future<RestaurantModel> fetchSingleRestaurantById({@required String id});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({@required this.client});

  final http.Client client;

  Map<String, String> _generateHeader() {
    Map<String, String> header = {"user-key": API_KEY};
    return header;
  }

  Exception _handleException(String response) {
    String message = "";
    int code = 0;
    if (response?.isNotEmpty ?? false) {
      final jsonResponse = json.decode(response);
      message = jsonResponse["message"] as String ?? "";
      code = jsonResponse["data"]["status"] as int ?? 0;
    }
    return ServerException(message: message, code: code);
  }

  @override
  Future<GeocodeResponse> fetchNearbyRestaurantsByCoordinates(
      {double lat, double lon}) async {
    final url =
        "https://developers.zomato.com/api/v2.1/geocode?lat=$lat&lon=$lon";
    print("Url : $url");
    try {
      final response = await client.get(url, headers: _generateHeader());
      printWrapped("response : ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return GeocodeResponse.fromJson(json.decode(response.body));
      } else {
        printWrapped("error : ${response.body}");
        throw _handleException(response?.body);
      }
    } catch (e) {
      printWrapped("error : ${e.toString()}");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<RestaurantModel> fetchSingleRestaurantById({String id}) async {
    final url = "https://developers.zomato.com/api/v2.1/restaurant?res_id=$id";
    print("Url : $url");
    try {
      final response = await client.get(url, headers: _generateHeader());
      printWrapped("response : ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return RestaurantModel.fromJson(json.decode(response.body));
      } else {
        printWrapped("error : ${response.body}");
        throw _handleException(response?.body);
      }
    } catch (e) {
      printWrapped("error : ${e.toString()}");
      throw ServerException(message: e.toString());
    }
  }
}
