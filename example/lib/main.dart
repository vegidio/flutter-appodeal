import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fl_toast/fl_toast.dart';

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
    );

    // Defining the callbacks
    Appodeal.setBannerCallback(
        (event) => print('Banner ad triggered the event $event'));
    Appodeal.setMrecCallback(
        (event) => print('MREC ad triggered the event $event'));
    Appodeal.setInterstitialCallback(
        (event) => print('Interstitial ad triggered the event $event'));
    Appodeal.setRewardCallback(
        (event) => print('Reward ad triggered the event $event'));
    Appodeal.setNonSkippableCallback(
        (event) => print('Non-skippable ad triggered the event $event'));

    // Request authorization to track the user
    Appodeal.requestIOSTrackingAuthorization().then((_) async {
      // Set interstitial ads to be cached manually
      await Appodeal.setAutoCache(AdType.INTERSTITIAL, false);

      // Initialize Appodeal after the authorization was granted or not
      await Appodeal.initialize(
          hasConsent: true,
          adTypes: [
            AdType.BANNER,
            AdType.MREC,
            AdType.INTERSTITIAL,
            AdType.REWARD,
            AdType.NON_SKIPPABLE
          ],
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
      child: SingleChildScrollView(
        child: IntrinsicWidth(
          child: Wrap(
            runSpacing: 8,
            spacing: double.infinity,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Should I collect user consent?'),
                onPressed: () async {
                  var shouldShow = await Appodeal.shouldShowConsent();

                  await showPlatformToast(
                      child: Text(
                          'The app should${shouldShow ? ' ' : ' NOT '}collect user consent'),
                      context: context,
                      duration: Duration(seconds: 4));
                },
              ),
              ElevatedButton(
                child: Text('Check GDPR/CCPA Consent Info'),
                onPressed: () async {
                  var consent = await Appodeal.fetchConsentInfo();

                  showPlatformToast(
                    child: Text(
                        'Status: ${consent.status}; Zone: ${consent.zone}'),
                    context: context,
                    duration: Duration(seconds: 4),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Request GDPR/CCPA Consent'),
                onPressed: () async {
                  await Appodeal.requestConsentAuthorization();
                },
              ),
              ElevatedButton(
                child: Text('Is Interstitial Ad ready for show?'),
                onPressed: () async {
                  var isReady =
                      await Appodeal.isReadyForShow(AdType.INTERSTITIAL);
                  showPlatformToast(
                    child: Text(isReady
                        ? 'Interstitial ad is ready'
                        : 'Interstitial ad is NOT ready'),
                    context: context,
                    duration: Duration(seconds: 4),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Cache Interstitial Ad'),
                onPressed: () async {
                  await Appodeal.cache(AdType.INTERSTITIAL);
                },
              ),
              ElevatedButton(
                child: Text('Show Interstitial Ad'),
                onPressed: () async {
                  await Appodeal.show(AdType.INTERSTITIAL,
                      placementName: "placement-name");
                },
              ),
              ElevatedButton(
                child: Text('Is Reward Ad ready for show?'),
                onPressed: () async {
                  var isReady = await Appodeal.isReadyForShow(AdType.REWARD);
                  showPlatformToast(
                    child: Text(isReady
                        ? 'Reward ad is ready'
                        : 'Reward ad is NOT ready'),
                    context: context,
                    duration: Duration(seconds: 4),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Show Reward Ad'),
                onPressed: () async {
                  var status = await Appodeal.show(AdType.REWARD,
                      placementName: 'placement-name');
                  print(status);
                },
              ),
              ElevatedButton(
                child: Text('Is Non-Skippable Ad ready?'),
                onPressed: () async {
                  var isReady =
                      await Appodeal.isReadyForShow(AdType.NON_SKIPPABLE);
                  showPlatformToast(
                    child: Text(isReady
                        ? 'Non-Skippable ad is ready'
                        : 'Non-Skippable ad is NOT ready'),
                    context: context,
                    duration: Duration(seconds: 4),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Can Show Non-Skippable Ad?'),
                onPressed: () async {
                  var canShow = await Appodeal.canShow(AdType.NON_SKIPPABLE,
                      placementName: "placement-name");
                  showPlatformToast(
                    child: Text(canShow
                        ? 'Non-Skippable can be shown'
                        : 'Non-Skippable can NOT be shown'),
                    context: context,
                    duration: Duration(seconds: 4),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Show Non-Skippable Ad'),
                onPressed: () async {
                  var status = await Appodeal.show(AdType.NON_SKIPPABLE);
                  print(status);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Text("Banner Ad"),
                    AppodealBanner(placementName: "placement-name"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Text("MREC Ad"),
                    AppodealMrec(placementName: "placement-name"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
