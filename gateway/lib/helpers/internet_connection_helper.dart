import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';

class InternetConnection {
  static Future<bool> hasInternetConnectivity() async {
    final hasConnection = await DataConnectionChecker().hasConnection;

    return hasConnection;
  }
}
