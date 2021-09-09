import 'package:appodeal_flutter/appodeal_flutter.dart';

import 'types.dart';

class Consent {
  List<String> acceptedVendors = [];
  int zone = ConsentZone.UNKNOWN;
  int status = ConsentStatus.UNKNOWN;

  Consent(Map consentMap) {
    acceptedVendors = (consentMap["acceptedVendors"] as List).whereType<String>().toList();

    switch (consentMap["status"]) {
      case 0:
        status = ConsentStatus.UNKNOWN;
        break;
      case 1:
        status = ConsentStatus.NON_PERSONALIZED;
        break;
      case 2:
        status = ConsentStatus.PARTLY_PERSONALIZED;
        break;
      case 3:
        status = ConsentStatus.PERSONALIZED;
        break;
    }

    switch (consentMap["zone"]) {
      case 0:
        zone = ConsentZone.UNKNOWN;
        break;
      case 1:
        zone = ConsentZone.NONE;
        break;
      case 2:
        zone = ConsentZone.GDPR;
        break;
      case 3:
        zone = ConsentZone.CCPA;
        break;
    }
  }
}
