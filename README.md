# appodeal_flutter

[![GitHub Actions](https://img.shields.io/github/workflow/status/vegidio/flutter-appodeal/build)](https://github.com/vegidio/flutter-appodeal/actions)
[![Pub Version](https://img.shields.io/pub/v/appodeal_flutter?color=blue)](https://pub.dev/packages/appodeal_flutter)
[![MIT License](https://img.shields.io/github/license/vegidio/flutter-appodeal?color=important)](LICENSE)

A Flutter plugin to display ads from Appodeal. It currently supports **Banner**, **MREC**, **Interstitial**, **Reward** and **Non-Skippable** ads.

## 📽 Demo

[![Demo](https://i.imgur.com/rrLm2ro.gif)](https://i.imgur.com/Rh2YwuW.mp4)

## ⚙️ Installation

1. Add the dependency to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  appodeal_flutter: # use the latest version
```

2. Install the plugin by running the command below in the terminal, in your project's root directory:

```
$ flutter pub get
```

3. Follow the Appodeal installation instructions available for [iOS](https://wiki.appodeal.com/en/ios/get-started) and [Android](https://wiki.appodeal.com/en/android/get-started). However, ignore the steps to include the Appodeal SDK dependencies in Gradle (Android) and Cocoapods (iOS) since these steps will be done by this package.

### Extra steps for Android only

4. The Appodeal framework includes mutiple libraries from different ad providers, so it's very likely that the inclusion of this plugin in your project will make it exceed to 64K limit method count of Android. To solve this problem you need to enable multidex in your project; follow the instructions [here](https://developer.android.com/studio/build/multidex) to learn how to do that.

5. Your Android project must use Gradle 4.0.1 or greater. If you are using an older version, please upgrade it by editing the file `android/build.gradle`.

### Extra step for iOS 14+ only

4. Follow the instructions available [here](https://wiki.appodeal.com/en/ios/get-started/data-protection/app-tracking-transparency) to learn how to implement the permission request to track users, but ignore the part to include some code in the `AppDelegate` file. This code is already included in this plugin and it will be executed when you call the function `Appodeal.requestIOSTrackingAuthorization()`, before the initialization of Appodeal (see below).

### If you don't use AdMob

This plugin comes with all possible ad networks supported by Appodeal enabled by default. I made this decision to give more flexibility to the developers using this project, but this comes with a drawback: if you don't intend to use **Google AdMob** in your app, then you are still forced to add a fake application ID in your project otherwise AdMob will make the app crash if it doesn't find an ID 😬

To add this fake AdMob ID (again, only if you don't intend to use AdMob, otherwise you should use your real AdMob identifier) you must:

#### Android

Edit the file `android/app/src/main/AndroidManifest.xml` and add this into the `<application>` tag:

```xml
<application ...>
    ...
    <meta-data
        android:name="com.google.android.gms.ads.APPLICATION_ID"
        android:value="ca-app-pub-0000000000000000~0000000000" />
    ...
</application>
```

#### iOS

Edit the file `ios/Runner/Info.plist` and add this into the `<dict>` tag:

```xml
<dict>
    ...
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-0000000000000000~0000000000</string>
    ...
</dict>
```

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

Where `androidAppKey` and `iosAppKey` are the keys associated with your app in your Appodeal account. At least one of these keys must be set before the initialization (either Android or iOS), otherwise you will get an error.

Afterwards you can initialize Appodeal with the function:

```dart
// Initialize Appodeal
await Appodeal.initialize(
  hasConsent: true,
  adTypes: [AdType.BANNER, AdType.MREC, AdType.INTERSTITIAL, AdType.REWARD, AdType.NON_SKIPPABLE],
  testMode: true,
  verbose: true,
);

// At this point you are ready to display ads
```
* `hasConsent` (mandatory) you must set either `true` or `false`, depending if the user granted access to be tracked in order to received better ads. See section about collecting user consent for more information.

* `adTypes` (optional) you must set a list (of type `AdType`) with all the ad types that you would like to display in your app. If this parameter is undefined or an empty list then no ads will be loaded.

* `testMode` (optional) you must set either `true` or `false` (default) depending if you are running the ads during development/test or production.

* `verbose` (optional) you must set either `true` or `false` (default) if you want Appodeal's verbose logs to be visible amongst the Flutter logs.

## 👮🏾‍♂️ Consent to track the user

Before you initialize the plugin and start displaying ads, you might need to collect the user's consent to be tracked online, depending on his location or the operating system that he is using.

### For iOS 14+ only

Since iOS 14+ you are required to request a specific permission before you can have access to Apple's IDFA (a sort of proprietary cookie used by Apple to track users among multiple advertisers... ah Apple, always Apple 🙄). To request this permission call the function `Appodeal.requestIOSTrackingAuthorization()`:

```dart
// iOS 14+: request permission to track users
// on iOS <= 13 and Android this function does nothing; it just returns true
await Appodeal.requestIOSTrackingAuthorization();
```

For iOS versions before 14 and for Android devices this function won't do anything, so it's safe to call it on any device OS or version.

### For users protected by GDPR/CCPA privacy laws

Depending on the location of your users, they might be protected by the privacy laws GDPR or CCPA. These laws require, among other things, that app developers must collect user consent before the advertisers can track them online. You can check if the user is protected by any privacy laws, by calling the function `Appodeal.shouldShowConsent()`:

```dart
bool shouldShow = await Appodeal.shouldShowConsent();
if (shouldShow) { /* Request user consent */ }
```

Keep in mind that the function above will also return `false` if the user previously accepted or declined the request to be tracked online. So it's important to always call this function in advance to avoid annoying the user with permission requests that he already answered.

After you determine if you need to request user consent, you have two options to collect this consent:

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

### Banner & MREC

To display a banner or MREC ad in your app, just include the widgets `AppodealBanner()` or `AppodealMrec()` somewhere in your widget tree. For example:

```dart
...
// Add a banner ad
Center(
  child: AppodealBanner()
),
// or a MREC ad
Center(
  child: AppodealMrec()
),
...
```

### Interstitial, Reward & Non-Skippable

To show an interstitial, reward or non-skippable ad, call the function `Appodeal.show()` passing the type of ad that you would like to show as a paremeter (mandatory) and the [placement name](https://faq.appodeal.com/en/articles/1154394-placements) (optional):

```dart
Appodeal.show(AdType.INTERSTITIAL, placementName: "placement-name");  // Show an interstitial ad
Appodeal.show(AdType.REWARD, placementName: "placement-name");        // Show a reward ad
Appodeal.show(AdType.NON_SKIPPABLE);                                  // Show a non-skippable ad without placement name
```

## ♻️ Callbacks

You can define callbacks to your ads and track when an event occurs; it can be done by calling the callback functions below:

- `Appodeal.setBannerCallback((event) {})`
- `Appodeal.setMrecCallback((event) {})`
- `Appodeal.setInterstitialCallback((event) {})`
- `Appodeal.setRewardCallback((event) {})`
- `Appodeal.setNonSkippableCallback((event) {})`

Every callback carries the parameter `event` of type `String` and you can use it to determine what event has been triggered. For example, if I wanted to know when the user watched a reward ad until the end, I could use the following callback code:

```dart
Appodeal.setRewardCallback((event) {
  if (event == 'onRewardedVideoFinished') {
    print('The user watched the reward ad until the end');
  }
})
```

and if later I don't want to track reward events anymore, I just need to pass the value `null` to the same callback function:

```dart
Appodeal.setRewardCallback(null);
```

The full list of events that you can track is below:

### Banner

`onBannerLoaded`, `onBannerFailedToLoad`, `onBannerShown`, `onBannerClicked`, `onBannerExpired`.

### MREC

`onMrecLoaded`, `onMrecFailedToLoad`, `onMrecShown`, `onMrecClicked`, `onMrecExpired`.

### Interstitial

`onInterstitialLoaded`, `onInterstitialFailedToLoad`, `onInterstitialShown`, `onInterstitialShowFailed`, `onInterstitialClicked`, `onInterstitialClosed`, `onInterstitialExpired`.

### Reward

`onRewardedVideoLoaded`, `onRewardedVideoFailedToLoad`, `onRewardedVideoShown`, `onRewardedVideoShowFailed`, `onRewardedVideoFinished`, `onRewardedVideoClosed`, `onRewardedVideoExpired`, `onRewardedVideoClicked`.

### Non-Skippable

`onNonSkippableVideoLoaded`, `onNonSkippableVideoFailedToLoad`, `onNonSkippableVideoShown`, `onNonSkippableVideoShowFailed`, `onNonSkippableVideoFinished`, `onNonSkippableVideoClosed`, `onNonSkippableVideoExpired`.

## 🙏🏾 Donations

If you like this project then please consider [becoming a sponsor](https://github.com/sponsors/vegidio). Your contribution will help me dedicate more time working on bugs and new features for this and other projects.

## 📝 License

**appodeal_flutter** is released under the MIT License. See [LICENSE](LICENSE) for details.

## 👨🏾‍💻 Author

Vinicius Egidio ([vinicius.io](https://vinicius.io))
