import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wiwalk_app/core/utils/logger.dart';

final connectivityManager = ConnectivityManager();

class ConnectivityManager extends ChangeNotifier {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future init() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      logger.i('Couldn\'t check connectivity status: $e');
      return;
    }

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;

    switch (connectionStatus) {
      case ConnectivityResult.wifi:
        logger.i('Device connected via Wi-Fi');
        break;
      case ConnectivityResult.mobile:
        logger.i('Device connected to cellular network');
        break;
      case ConnectivityResult.bluetooth:
        logger.i('Device connected via bluetooth');
        break;
      case ConnectivityResult.ethernet:
        logger.i('Device connected to ethernet network');
        break;
      case ConnectivityResult.none:
      default:
        logger.i('Device not connected to any network');
        break;
    }
  }

  bool isOnline() {
    switch (connectionStatus) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.ethernet:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.none:
      default:
        break;
    }

    return false;
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}
