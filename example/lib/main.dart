import 'package:flutter/material.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAppodealInitialized = false;

  @override
  void initState() {
    super.initState();

    // Set the app keys
    Appodeal.setAppKeys(
        androidAppKey: 'f1e6435dfa48cb71bb6753f1c8ac97bba6609d481e63bb98',
        iosAppKey: '3a2ef99639e29dfe3333e4b3b496964dae6097cc510cbb2f');

    // Defining the callbacks
    Appodeal.setBannerCallback((event) => print('Banner ad triggered the event $event'));
    Appodeal.setInterstitialCallback((event) => print('Interstitial ad triggered the event $event'));
    Appodeal.setRewardCallback((event) => print('Reward ad triggered the event $event'));
    Appodeal.setNonSkippableCallback((event) => print('Non-skippable ad triggered the event $event'));

    // Request authorization to track the user
    Appodeal.requestIOSTrackingAuthorization().then((_) async {
      // Set interstitial ads to be cached manually
      await Appodeal.setAutoCache(AdType.INTERSTITIAL, false);

      // Initialize Appodeal after the authorization was granted or not
      await Appodeal.initialize(
          hasConsent: true,
          adTypes: [AdType.BANNER, AdType.INTERSTITIAL, AdType.REWARD, AdType.NON_SKIPPABLE],
          testMode: true);

      setState(() => this.isAppodealInitialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Appodeal Example App'),
          ),
          body: isAppodealInitialized ? _Body() : Container()),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Should I collect user consent?'),
              onPressed: () async {
                var shouldShow = await Appodeal.shouldShowConsent();

                Toast.show('The app should${shouldShow ? ' ' : ' NOT '}collect user consent', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            RaisedButton(
              child: Text('Check GDPR/CCPA Consent Info'),
              onPressed: () async {
                var consent = await Appodeal.fetchConsentInfo();

                Toast.show('Status: ${consent.status}; Zone: ${consent.zone}', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            RaisedButton(
              child: Text('Request GDPR/CCPA Consent'),
              onPressed: () async {
                await Appodeal.requestConsentAuthorization();
              },
            ),
            RaisedButton(
              child: Text('Is Interstitial Ad ready for show?'),
              onPressed: () async {
                var isReady = await Appodeal.isReadyForShow(AdType.INTERSTITIAL);
                Toast.show(isReady ? 'Interstitial ad is ready' : 'Interstitial ad is NOT ready', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            RaisedButton(
              child: Text('Cache Interstitial Ad'),
              onPressed: () async {
                await Appodeal.cache(AdType.INTERSTITIAL);
              },
            ),
            RaisedButton(
              child: Text('Show Interstitial Ad'),
              onPressed: () async {
                await Appodeal.show(AdType.INTERSTITIAL, placementName: "placement-name");
              },
            ),
            RaisedButton(
              child: Text('Is Reward Ad ready for show?'),
              onPressed: () async {
                var isReady = await Appodeal.isReadyForShow(AdType.REWARD);
                Toast.show(isReady ? 'Reward ad is ready' : 'Reward ad is NOT ready', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            RaisedButton(
              child: Text('Show Reward Ad'),
              onPressed: () async {
                var status = await Appodeal.show(AdType.REWARD, placementName: 'placement-name');
                print(status);
              },
            ),
            RaisedButton(
              child: Text('Is Non-Skippable Ad ready?'),
              onPressed: () async {
                var isReady = await Appodeal.isReadyForShow(AdType.NON_SKIPPABLE);
                Toast.show(isReady ? 'Non-Skippable ad is ready' : 'No-Skippable ad is NOT ready', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            RaisedButton(
              child: Text('Can Show Non-Skippable Ad?'),
              onPressed: () async {
                var canShow = await Appodeal.canShow(AdType.NON_SKIPPABLE, placementName: "placement-name");
                Toast.show(canShow ? 'Non-Skippable can be shown' : 'Non-Skippable can NOT be shown', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            RaisedButton(
              child: Text('Show Non-Skippable Ad'),
              onPressed: () async {
                var status = await Appodeal.show(AdType.NON_SKIPPABLE);
                print(status);
              },
            ),
            AppodealBanner(placementName: "placement-name"),
          ],
        ),
      ),
    );
  }
}
