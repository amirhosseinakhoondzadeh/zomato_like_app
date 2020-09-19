import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zomato_like_app/core/network_info/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features

  /// Core & External Libraries
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
