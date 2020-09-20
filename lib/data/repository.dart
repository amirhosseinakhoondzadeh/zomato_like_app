import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zomato_like_app/core/error/exceptions.dart';
import 'package:zomato_like_app/core/error/failures.dart';
import 'package:zomato_like_app/core/helpers/print_wrapper.dart';
import 'package:zomato_like_app/core/network_info/network_info.dart';
import 'package:zomato_like_app/data/datasources/local_data_source.dart';
import 'package:zomato_like_app/data/datasources/remote_data_source.dart';

import 'models/geocode_response.dart';

abstract class Repository {
  Future<Either<Failure, GeocodeResponse>> fetchNearbyRestaurantsByCoordinates(
      {@required double lat, @required double lon});

  Future<Either<Failure, RestaurantModel>> fetchSingleRestaurantById(
      {@required String id});
}

class RepositoryImpl implements Repository {
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GeocodeResponse>> fetchNearbyRestaurantsByCoordinates(
      {double lat, double lon}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await remoteDataSource
            .fetchNearbyRestaurantsByCoordinates(lat: lat, lon: lon);
        printWrapped("response is : $response");
        return Right(response);
      } on ServerException catch (e) {
        printWrapped("ServerException : ${e.message}");
        return Left(ServerFailure(customMessage: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, RestaurantModel>> fetchSingleRestaurantById(
      {String id}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response =
            await remoteDataSource.fetchSingleRestaurantById(id: id);
        printWrapped("response is : $response");
        return Right(response);
      } on ServerException catch (e) {
        printWrapped("ServerException : ${e.message}");
        return Left(ServerFailure(customMessage: e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
