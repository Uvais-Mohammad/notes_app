import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:notes_app/shared/services/connection_service/i_connection_service.dart';

final connectionServiceProvider =
    Provider<IConnectionService>((ref) => ConnectionService());

final class ConnectionService implements IConnectionService {
  final internetConnection = InternetConnection();

  @override
  Future<bool> get isConnected => internetConnection.hasInternetAccess;

  @override
  Stream<InternetStatus> get onStatusChange =>
      internetConnection.onStatusChange;
}
