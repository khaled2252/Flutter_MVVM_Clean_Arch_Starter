import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo { //Todo replace InternetConnectionChecker with another that works for web, now it returns true in all cases
  @override
  Future<bool> get isConnected => Future.value(true);
}
