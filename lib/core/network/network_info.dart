import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker _checker;
  const NetworkInfoImpl(this._checker);

  @override
  Future<bool> get isConnected => _checker.hasConnection;
}
