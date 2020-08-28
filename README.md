# appodeal_flutter

[![GitHub Actions](https://img.shields.io/github/workflow/status/vegidio-flutter/appodeal/test?label=tests)](https://github.com/vegidio-flutter/appodeal/actions)
[![Pub Version](https://img.shields.io/pub/v/appodeal_flutter)](https://pub.dev/packages/appodeal_flutter)
[![ISC License](https://img.shields.io/npm/l/vimdb?color=important)](LICENSE)

A Flutter plugin to display ads from Appodeal. It current supports __Banner__, __Interstitial__, __Reward__ and __Non-Skippable__ ads.

## 🚧 Under development

🔴 **ATTENTION: This plugin is under development and is considered to be in ALPHA STAGE. It means that many features are not implemented yet and/or subject of change in future releases. While some things are already working, please use caution when using this plugin in production.**

### Roadmap

- ~~Display banner ads.~~
- ~~Display interstitial ads.~~
- ~~Display reward ads.~~
- Create callbacks to be notified of events when ads don't load, when they are closed, rewarded, etc.
- Support for iOS 14+.
- Support for floating banner ads.
- Support for Consent Manager framework.
- Ability to cache ads manually.
- Other features under consideration...

## ⚙️ Installation

1. Add the dependency to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  appodeal_flutter: "^0.0.1"
```

2. Install the package by running the command below in the terminal, in your project's root directory:

```
$ flutter pub get
```

## 📱 Usage

Import the package as early as possible somewhere in your project (ideally in the file `main.dart`) and then initialize the plugin using calling the method `Appodeal.initialize()`:

### Initialization

```dart
import 'package:appodeal_flutter/appodeal_flutter.dart';

Appodeal.initialize(
  androidAppKey: '<your-appodeal-android-key>',
  iosAppKey: '<your-appodeal-ios-key>',
  adTypes: [AppodealAdType.BANNER, AppodealAdType.INTERSTITIAL, AppodealAdType.REWARD],
  testMode: true
);
```

* `androidAppKey` and `iosAppKey` (mandatory): you must set these fields with the appropriate key associated with your app in your Appodeal account. You must set at least one of these fields during the initialization (either Android or iOS). If no key is set then this function will throw an error.

* `adTypes` (optional) you must set a list (of type `AppodealAdType`) with all the ad types that you would like to present in your app. If this parameter is undefined or an empty list then no ads will be loaded.

* `testMode` (optional) you must set `false` (default) or `true` depending if you are running the ads during development/test or production.

### Banner ads

To include a banner ad in UI, just include the `AppodealBanner` somewhere in your widget tree:

```dart
...
Center(
  child: AppodealBanner()
)
...
```

### Interstitial & Reward ads

To show an interstitial or a reward ad, call the function `Appodeal.show()` passing the type of ad that you would show to show as a paremeter:

```dart
Appodeal.show(AppodealAdType.INTERSTITIAL)  // Show an interstitial ad
Appodeal.show(AppodealAdType.REWARD)        // Show a reward ad
```

## 📝 License

**appodeal_flutter** is released under the ISC License. See [LICENSE](LICENSE) for details.

## 👨🏾‍💻 Author

Vinicius Egidio ([vinicius.io](http://vinicius.io))