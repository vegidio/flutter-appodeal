class AdType {
  static const NONE = 0;
  static const BANNER = 1;
  static const NATIVE = 2;
  static const INTERSTITIAL = 3;
  static const REWARD = 4;
  static const NON_SKIPPABLE = 5;
  static const MREC = 6;
}

class ConsentZone {
  static const NONE = 0;
  static const UNKNOWN = 1;
  static const GDPR = 2;
  static const CCPA = 3;
}

class ConsentStatus {
  static const UNKNOWN = 0;
  static const NON_PERSONALIZED = 1;
  static const PARTLY_PERSONALIZED = 2;
  static const PERSONALIZED = 3;
}
