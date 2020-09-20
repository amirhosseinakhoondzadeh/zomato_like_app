import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl({@required this.sharedPreferences});

  final SharedPreferences sharedPreferences;
}
