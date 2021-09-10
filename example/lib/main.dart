import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  Fimber.plantTree(DebugTree());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
    Appodeal.setBannerCallback((event) => Fimber.i('Banner ad triggered the event $event'));
    Appodeal.setMrecCallback((event) => Fimber.i('MREC ad triggered the event $event'));
    Appodeal.setInterstitialCallback((event) => Fimber.i('Interstitial ad triggered the event $event'));
    Appodeal.setRewardCallback((event) => Fimber.i('Reward ad triggered the event $event'));
    Appodeal.setNonSkippableCallback((event) => Fimber.i('Non-skippable ad triggered the event $event'));

    // Request authorization to track the user
    Appodeal.requestIOSTrackingAuthorization().then((_) async {
      // Set interstitial ads to be cached manually
      await Appodeal.setAutoCache(AdType.interstitial, false);

      // Initialize Appodeal after the authorization was granted or not
      await Appodeal.initialize(
          hasConsent: true,
          adTypes: [AdType.banner, AdType.mrec, AdType.interstitial, AdType.reward, AdType.nonSkippable],
          testMode: true);

      setState(() => isAppodealInitialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Appodeal Example App'),
          ),
          body: isAppodealInitialized
              ? SafeArea(child: SingleChildScrollView(child: IntrinsicWidth(child: _Body())))
              : Container()),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: double.infinity,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('Should I collect user consent?'),
          onPressed: () async {
            var shouldShow = await Appodeal.shouldShowConsent();
            Fluttertoast.showToast(
                msg: 'The app should${shouldShow ? ' ' : ' NOT '}collect user consent',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM);
          },
        ),
        ElevatedButton(
          child: const Text('Check GDPR/CCPA Consent Info'),
          onPressed: () async {
            var consent = await Appodeal.fetchConsentInfo();
            Fluttertoast.showToast(
                msg: 'Status: ${consent.status}; Zone: ${consent.zone}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM);
          },
        ),
        ElevatedButton(
          child: const Text('Request GDPR/CCPA Consent'),
          onPressed: () async {
            await Appodeal.requestConsentAuthorization();
          },
        ),
        ElevatedButton(
          child: const Text('Is Interstitial Ad ready for show?'),
          onPressed: () async {
            var isReady = await Appodeal.isReadyForShow(AdType.interstitial);
            Fluttertoast.showToast(
                msg: isReady ? 'Interstitial ad is ready' : 'Interstitial ad is NOT ready',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM);
          },
        ),
        ElevatedButton(
          child: const Text('Cache Interstitial Ad'),
          onPressed: () async {
            await Appodeal.cache(AdType.interstitial);
          },
        ),
        ElevatedButton(
          child: const Text('Show Interstitial Ad'),
          onPressed: () async {
            await Appodeal.show(AdType.interstitial, placementName: "placement-name");
          },
        ),
        ElevatedButton(
          child: const Text('Is Reward Ad ready for show?'),
          onPressed: () async {
            var isReady = await Appodeal.isReadyForShow(AdType.reward);
            Fluttertoast.showToast(
                msg: isReady ? 'Reward ad is ready' : 'Reward ad is NOT ready',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM);
          },
        ),
        ElevatedButton(
          child: const Text('Show Reward Ad'),
          onPressed: () async {
            var status = await Appodeal.show(AdType.reward, placementName: 'placement-name');
            Fimber.i("$status");
          },
        ),
        ElevatedButton(
          child: const Text('Is Non-Skippable Ad ready?'),
          onPressed: () async {
            var isReady = await Appodeal.isReadyForShow(AdType.nonSkippable);
            Fluttertoast.showToast(
                msg: isReady ? 'Non-Skippable ad is ready' : 'No-Skippable ad is NOT ready',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM);
          },
        ),
        ElevatedButton(
          child: const Text('Can Show Non-Skippable Ad?'),
          onPressed: () async {
            var canShow = await Appodeal.canShow(AdType.nonSkippable, placementName: "placement-name");
            Fluttertoast.showToast(
                msg: canShow ? 'Non-Skippable can be shown' : 'Non-Skippable can NOT be shown',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM);
          },
        ),
        ElevatedButton(
          child: const Text('Show Non-Skippable Ad'),
          onPressed: () async {
            var status = await Appodeal.show(AdType.nonSkippable);
            Fimber.i("$status");
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              const Text("Banner Ad"),
              AppodealBanner(placementName: "placement-name"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              const Text("MREC Ad"),
              AppodealMrec(placementName: "placement-name"),
            ],
          ),
        )
      ],
    );
  }
}
