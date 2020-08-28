# appodeal_flutter

[![GitHub Actions](https://img.shields.io/github/workflow/status/vegidio-flutter/appodeal/test?label=tests)](https://github.com/vegidio-flutter/appodeal/actions)
[![Pub Version](https://img.shields.io/pub/v/appodeal_flutter)](https://pub.dev/packages/appodeal_flutter)
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
- Support for Consent Manager framework (GDPR/CCPA consent status).
- Create callbacks to be notified of events when ads don't load, when they are closed, rewarded, etc.
- Support for floating banner ads.
- Ability to cache ads manually.
- Other features under consideration...

## ⚙️ Installation

1. Add the dependency to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  appodeal_flutter: "^0.0.3"
```

2. Install the package by running the command below in the terminal, in your project's root directory:

```
$ flutter pub get
```

3. Follow the Appodeal installation instructions available for [iOS](https://wiki.appodeal.com/en/ios/2-7-3-beta-ios-sdk-integration-guide) and [Android](https://wiki.appodeal.com/en/android/2-7-3-beta-android-sdk-integration-guide). However, ignore the steps to include the Appodeal SDK dependencies in your Gradle files (Android) and the Cocoapods dependencies (iOS) since both steps are already done by this Flutter package.

### Extra step For iOS 14+ only

4. Follow the instructions available [here](https://wiki.appodeal.com/en/ios/2-7-3-beta-ios-sdk-integration-guide/ios-14+-support) on how to implement the permission request to track users, but ignore the part to include some code in the `AppDelegate` file. This code will be executed when you call the function `Appodeal.requestTrackingAuthorization()`, before the initialization of Appodeal (see below).

## 📱 Usage

Import the package as early as possible somewhere in your project (ideally in the file `main.dart`), then initialize the plugin by calling the method `Appodeal.initialize()`:

### Initialization

```dart
import 'package:appodeal_flutter/appodeal_flutter.dart';

// iOS 14+: request permission to track users
// on iOS <= 13 and on Android this function does nothing and just returns true
await Appodeal.requestTrackingAuthorization();

// Initialize Appodeal
await Appodeal.initialize(
  androidAppKey: '<your-appodeal-android-key>',
  iosAppKey: '<your-appodeal-ios-key>',
  adTypes: [AppodealAdType.BANNER, AppodealAdType.INTERSTITIAL, AppodealAdType.REWARD],
  testMode: true
);

// At this point you can safely display ads
```

* `androidAppKey` and `iosAppKey` (mandatory): you must set these fields with the appropriate key associated with your app in your Appodeal account. At least one of these keys must be defined during the initialization (either Android or iOS), otherwise this function will throw an error.

* `adTypes` (optional) you must set a list (of type `AppodealAdType`) with all the ad types that you would like to display in your app. If this parameter is undefined or an empty list then no ads will be loaded.

* `testMode` (optional) you must set `false` (default) or `true` depending if you are running the ads during development/test or production.

### Banner ads

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
Appodeal.show(AppodealAdType.INTERSTITIAL)  // Show an interstitial ad
Appodeal.show(AppodealAdType.REWARD)        // Show a reward ad
Appodeal.show(AppodealAdType.NON_SKIPPABLE) // Show a non-skippable ad
```

## 📝 License

**appodeal_flutter** is released under the ISC License. See [LICENSE](LICENSE) for details.

## 👨🏾‍💻 Author

Vinicius Egidio ([vinicius.io](https://vinicius.io))