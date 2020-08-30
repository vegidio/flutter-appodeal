import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'consent.dart';

class Appodeal {
  static String _androidAppKey;
  static String _iosAppKey;
  static const MethodChannel _channel = const MethodChannel('appodeal_flutter');

  /// Request the user authorization to track him across multiple apps and websites in order to deliver more relevant
  /// ads. This command must be called before the initialization of the Appodeal plugin.
  ///
  /// This authorization request is only relevant for iOS 14+. In older versions of iOS and on Android devices this
  /// function nothing. It simply returns `true` as if the authorization had already been granted.
  ///
  /// On devices with iOS 14+ it returns `true` or `false` depending whether the user granted access or not.
  static Future<void> requestiOSTrackingAuthorization() async {
    if (Platform.isIOS) await _channel.invokeMethod('requestTrackingAuthorization');
  }

  // region - Appodeal
  /// Define the app keys for Android and iOS, according to the values available in your Appodeal account. At least of
  /// of the keys must be set, otherwise an error will be throw during the initialization.
  static void setAppKeys({String androidAppKey, String iosAppKey}) {
    _androidAppKey = androidAppKey;
    _iosAppKey = iosAppKey;
  }

  /// Initialize the Appodeal plugin.
  ///
  /// During the initialization you must define the type of ads [adTypes] that you would like to display in your app and
  /// also if ads should be presented in test mode [testMode] or not. Always set test mode as `true` during development
  /// or tests.
  static Future<void> initialize({@required bool hasConsent, List<int> adTypes = const [], bool testMode = false}) async {
    assert(_androidAppKey != null || _iosAppKey != null, 'You must set at least one of the keys for Android or iOS');

    await _channel.invokeMethod('initialize', {
      'androidAppKey': _androidAppKey,
      'iosAppKey': _iosAppKey,
      'hasConsent': hasConsent,
      'adTypes': adTypes,
      'testMode': testMode
    });
  }

  /// Check if an ad of certain type [adType] is loaded and ready to be presented.
  ///
  /// Use the constants in the class `AdType` to specify what ad should be loaded.
  ///
  /// Returns `true` if the ad is loaded.
  static Future<bool> isLoaded(int adType) async {
    return _channel.invokeMethod('isLoaded', {
      'adType': adType
    });
  }

  /// Presents an ad of certain type [adType].
  ///
  /// Use the constants in the class `AdType` to specify what ad should be shown.
  ///
  /// Returns `true` if the ad is shown.
  static Future<bool> show(int adType) async {
    return _channel.invokeMethod('show', {
      'adType': adType
    });
  }
  // endregion

  // region - Consent Manager
  /// Fetches the user consent status, respecting the GDPR and CCPA laws, about tracking individuals across multiple
  /// sites and apps.
  ///
  /// Returns an object of type `Consent` where you can check the user status and in what zone, if any, that consent
  /// applies.
  static Future<Consent> fetchConsentInfo() async {
    assert(_androidAppKey != null || _iosAppKey != null, 'You must set at least one of the keys for Android or iOS');

    var consentMap = await _channel.invokeMethod('fetchConsentInfo', {
      'androidAppKey': _androidAppKey,
      'iosAppKey': _iosAppKey
    });

    return Consent(consentMap);
  }

  /// Displays a dialog window where the user can grant or deny access to be granted across multiple sites and devices,
  /// according to GDPR or CCPA laws.
  static Future<void> requestConsentAuthorization() async {
    await fetchConsentInfo();
    return _channel.invokeMethod('requestConsentAuthorization');
  }
  // endregion
}