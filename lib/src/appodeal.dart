import 'dart:async';

import 'package:flutter/services.dart';

class Appodeal {
  static const MethodChannel _channel = const MethodChannel('appodeal_flutter');

  static Future<void> initialize({
    String androidAppKey,
    String iosAppKey,
    List<int> adTypes = const [],
    bool testMode = false
  }) async {
    await _channel.invokeMethod('initialize', {
      'androidAppKey': androidAppKey,
      'iosAppKey': iosAppKey,
      'adTypes': adTypes,
      'testMode': testMode
    });
  }

  static Future<bool> isLoaded(int adType) async {
    return _channel.invokeMethod('isLoaded', {
      'adType': adType
    });
  }

  static Future<bool> show(int adType) async {
    return _channel.invokeMethod('show', {
      'adType': adType
    });
  }
}