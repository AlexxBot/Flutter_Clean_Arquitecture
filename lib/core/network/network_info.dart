//import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  String get url;
}

class NetworkInfoImpl implements NetworkInfo {
  //final DataConnectionChecker connectionChecker;
  final String url;
  NetworkInfoImpl(/* this.connectionChecker */ this.url);

  @override
  Future<bool> get isConnected => /* connectionChecker.hasConnection */ Future
      .value(true);
}
