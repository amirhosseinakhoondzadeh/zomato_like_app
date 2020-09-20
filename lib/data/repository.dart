import 'package:meta/meta.dart';
import 'package:zomato_like_app/core/network_info/network_info.dart';
import 'package:zomato_like_app/data/datasources/local_data_source.dart';
import 'package:zomato_like_app/data/datasources/remote_data_source.dart';

abstract class Repository {}

class RepositoryImpl implements Repository {
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });
}
