import 'package:appodeal_flutter/appodeal_flutter.dart';

import 'types.dart';

class Consent {
  List<String> acceptedVendors = [];
  int zone = ConsentZone.unknown;
  int status = ConsentStatus.unknown;

  Consent(Map consentMap) {
    acceptedVendors = (consentMap["acceptedVendors"] as List).whereType<String>().toList();

    switch (consentMap["status"]) {
      case 0:
        status = ConsentStatus.unknown;
        break;
      case 1:
        status = ConsentStatus.nonPersonalized;
        break;
      case 2:
        status = ConsentStatus.partlyPersonalized;
        break;
      case 3:
        status = ConsentStatus.personalized;
        break;
    }

    switch (consentMap["zone"]) {
      case 0:
        zone = ConsentZone.unknown;
        break;
      case 1:
        zone = ConsentZone.none;
        break;
      case 2:
        zone = ConsentZone.gdpr;
        break;
      case 3:
        zone = ConsentZone.ccpa;
        break;
    }
  }
}
