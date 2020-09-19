import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl extends NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);

  @override
  Future<bool> isConnected() => dataConnectionChecker.hasConnection;
}
