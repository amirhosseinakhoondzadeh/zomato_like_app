import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zomato_like_app/blocs/home/home_bloc.dart';
import 'package:zomato_like_app/blocs/side_bar/side_bar_bloc.dart';
import 'package:zomato_like_app/core/network_info/network_info.dart';
import 'package:zomato_like_app/data/datasources/local_data_source.dart';
import 'package:zomato_like_app/data/datasources/remote_data_source.dart';
import 'package:zomato_like_app/data/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Blocs
  sl.registerFactory(
    () => SideBarBloc(),
  );

  sl.registerFactory(
    () => HomeBloc(geolocatorPlatform: sl(), repository: sl()),
  );

  /// Repository
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  /// Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  /// Core & External Libraries
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => GeolocatorPlatform.instance);
}
