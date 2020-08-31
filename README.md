# appodeal_flutter

[![GitHub Actions](https://img.shields.io/github/workflow/status/vegidio-flutter/appodeal/build)](https://github.com/vegidio-flutter/appodeal/actions)
[![Pub Version](https://img.shields.io/pub/v/appodeal_flutter?color=blue)](https://pub.dev/packages/appodeal_flutter)
[![ISC License](https://img.shields.io/npm/l/vimdb?color=important)](LICENSE)

A Flutter plugin to display ads from Appodeal. It current supports __Banner__, __Interstitial__, __Reward__ and __Non-Skippable__ ads.

## 🚧 Under development

🔴 **ATTENTION: This plugin is under development and is considered to be in ALPHA STAGE. It means that many features are not implemented yet and/or are subject of change in future releases. While some things are already working, please use caution when using this plugin in production apps.**

### Roadmap

- ~~Display banner ads.~~
- ~~Display interstitial ads.~~
- ~~Display reward ads.~~
- ~~Display non-skippable ads.~~
- ~~Support for iOS 14+.~~
- ~~Support for Consent Manager framework (GDPR/CCPA privacy laws).~~
- Create callbacks to be notified of events when ads don't load, when they are closed, rewarded, etc.
- Support for floating banner ads.
- Ability to cache ads manually.
- Other features under consideration...

## ⚙️ Installation

1. Add the dependency to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  appodeal_flutter: "^0.1.3"
```

2. Install the plugin by running the command below in the terminal, in your project's root directory:

```
$ flutter pub get
```

3. Follow the Appodeal installation instructions available for [iOS](https://wiki.appodeal.com/en/ios/2-7-3-beta-ios-sdk-integration-guide) and [Android](https://wiki.appodeal.com/en/android/2-7-3-beta-android-sdk-integration-guide). However, ignore the steps to include the Appodeal SDK dependencies in Gradle (Android) and Cocoapods (iOS) since these steps will be done by this package.

### Extra step For Android only

4. The Appodeal framework includes mutiple libraries from different ad providers, so it's very likely that the inclusion of this plugin in your project will make it exceed to 64K limit method count of Android. To solve this problem you need to enable multidex in your project; follow the instructions [here](https://developer.android.com/studio/build/multidex) to learn how to do that.

### Extra step For iOS 14+ only

4. Follow the instructions available [here](https://wiki.appodeal.com/en/ios/2-7-3-beta-ios-sdk-integration-guide/ios-14+-support) to learn how to implement the permission request to track users, but ignore the part to include some code in the `AppDelegate` file. This code will be executed when you call the function `Appodeal.requestIOSTrackingAuthorization()`, before the initialization of Appodeal (see below).

## 📱 Usage

Import the plugin as early as possible somewhere in your project (ideally in the file `main.dart`), then initialize the plugin by calling the functions `Appodeal.setAppKeys()` and `Appodeal.initialize()`:

### Initialization

First you need to set the app keys:

```dart
// Set the Appodeal app keys
Appodeal.setAppKeys(
  androidAppKey: '<your-appodeal-android-key>',
  iosAppKey: '<your-appodeal-ios-key>',
);
```

Where `androidAppKey` and `iosAppKey` are the keys associated with your app in your Appodeal account. At least one of these keys must be set before the the initialization (either Android or iOS), otherwise you will get an error.

Afterwards you can initialize Appodeal with the function:

```dart
// Initialize Appodeal
await Appodeal.initialize(
  hasConsent: true,
  adTypes: [AdType.BANNER, AdType.INTERSTITIAL, AdType.REWARD],
  testMode: true
);

// At this point you are ready to display ads
```
* `hasConsent` (mandatory) you must pass `true` or `false`, depending if the user granted access to be tracked in order to received better ads. See section about collecting user consent for more information.

* `adTypes` (optional) you must set a list (of type `AdType`) with all the ad types that you would like to display in your app. If this parameter is undefined or an empty list then no ads will be loaded.

* `testMode` (optional) you must set `false` (default) or `true` depending if you are running the ads during development/test or production.

### Collecting user consent

Before you initialize the plugin and start displaying ads, you might need to collect the user's consent to be tracked online, depending on his location or the operating system that he is using.

Since iOS 14+ you are required to request a specific permission before you can have access to Apple's IDFA (a sort of proprietary cookie used by Apple to track users among multiple advertisers... ah Apple, always Apple 😒). For iOS versions before 14 and for Android devices this function won't do anything, so it's safe to call it on any device OS or version.

```dart
// iOS 14+: request permission to track users
// on iOS <= 13 and on Android this function does nothing
await Appodeal.requestIOSTrackingAuthorization();
```

Depending on the location of your users, they might be protected by the privacy laws GDPR or CCPA. These laws require, among other things, that app developers must collect user consent before the adverstisers can track them online. You have two options to collect the user consent:

1. You can design the UI with all the legal information and multiple options to let the user decline, accept or partially accept the options to be tracked. After you collect this information yourself, you then need to pass the value `true` or `false` to the parameter `hasConsent` during the Appodeal initialization.

or:

2. You can use the UI provided by the Consent Manager framework. With this option you can't customize the UI used to collect the user consent, however it does the heavy lifting for you of creating and displaying a window with all the legal wording, permission options and everything that is necessary to get the user's permission to be tracked. If you decide to go with option # 2 then you must call two functions:

    2.1. Call the function `Appodeal.requestConsentAuthorization()` to display a window requesting the user consent to be tracked:
    ```dart
    await Appodeal.requestConsentAuthorization();
    ```

    2.2. After the user grants or decline consent, you can call the function `Appodeal.fetchConsentInfo()` to fetch the consent info:
    ```dart
    var consent = await Appodeal.fetchConsentInfo();
    var hasConsent = consent.status == ConsentStatus.PERSONALIZED || consent.status == ConsentStatus.PARTLY_PERSONALIZED;
    await Appodeal.initialize(hasConsent: hasConsent, ...)
    ```

## 💵 Showing ads

After you collect all the permissions and the plugin properly initialized, you are ready to display the ads:

### Banner

To display a banner ad in your app, just include the `AppodealBanner()` widget somewhere in your widget tree. For example:

```dart
...
Center(
  child: AppodealBanner()
)
...
```

### Interstitial, Reward & Non-Skippable ads

To show an interstitial, reward or non-skippable ad, call the function `Appodeal.show()` passing the type of ad that you would like to show as a paremeter:

```dart
Appodeal.show(AdType.INTERSTITIAL);  // Show an interstitial ad
Appodeal.show(AdType.REWARD);        // Show a reward ad
Appodeal.show(AdType.NON_SKIPPABLE); // Show a non-skippable ad
```

## 📝 License

**appodeal_flutter** is released under the ISC License. See [LICENSE](LICENSE) for details.

## 👨🏾‍💻 Author

Vinicius Egidio ([vinicius.io](https://vinicius.io))