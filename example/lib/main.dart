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
      iosAppKey: '3a2ef99639e29dfe3333e4b3b496964dae6097cc510cbb2f'
    );

    // Request authorization to track the user
    Appodeal.requestIOSTrackingAuthorization().then((_) async {
      // Initialize Appodeal after the authorization was granted or not
      await Appodeal.initialize(
        hasConsent: true,
        adTypes: [
          AdType.BANNER,
          AdType.INTERSTITIAL,
          AdType.REWARD,
          AdType.NON_SKIPPABLE
        ],
        testMode: true
      );

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
            child: Text('Check: Is Interstitial Ad loaded?'),
            onPressed: () async {
              var isLoaded = await Appodeal.isLoaded(AdType.INTERSTITIAL);
              Toast.show(isLoaded ? 'Interstitial ad is loaded' : 'Interstitial ad is NOT loaded', context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            },
          ),

          RaisedButton(
            child: Text('Show Interstitial Ad'),
            onPressed: () async {
              await Appodeal.show(AdType.INTERSTITIAL);
            },
          ),

          RaisedButton(
            child: Text('Check: Is Reward Ad loaded?'),
            onPressed: () async {
              var isLoaded = await Appodeal.isLoaded(AdType.REWARD);
              Toast.show(isLoaded ? 'Reward ad is loaded' : 'Reward ad is NOT loaded', context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            },
          ),

          RaisedButton(
            child: Text('Show Reward Ad'),
            onPressed: () async {
              var status = await Appodeal.show(AdType.REWARD);
              print(status);
            },
          ),

          RaisedButton(
            child: Text('Check: Is Non-Skippable Ad loaded?'),
            onPressed: () async {
              var isLoaded = await Appodeal.isLoaded(AdType.NON_SKIPPABLE);
              Toast.show(isLoaded ? 'Non-Skippable ad is loaded' : 'No-Skippable ad is NOT loaded', context,
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

          AppodealBanner()
        ],
      ),
    );
  }
}