class AdType {
  static const none = 0;
  static const banner = 1;
  static const native = 2;
  static const interstitial = 3;
  static const reward = 4;
  static const nonSkippable = 5;
  static const mrec = 6;
}

class ConsentZone {
  static const none = 0;
  static const unknown = 1;
  static const gdpr = 2;
  static const ccpa = 3;
}

class ConsentStatus {
  static const unknown = 0;
  static const nonPersonalized = 1;
  static const partlyPersonalized = 2;
  static const personalized = 3;
}
