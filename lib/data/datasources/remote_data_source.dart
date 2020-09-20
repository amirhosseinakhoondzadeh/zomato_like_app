import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class RemoteDataSource {}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({@required this.client});

  final http.Client client;
}
