import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class IConnectionService {
  Future<bool> get isConnected;
  Stream<InternetStatus> get onStatusChange;
}