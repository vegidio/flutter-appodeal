import 'package:flutter/material.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Appodeal.initialize(
      androidAppKey: 'f1e6435dfa48cb71bb6753f1c8ac97bba6609d481e63bb98',
      iosAppKey: '3a2ef99639e29dfe3333e4b3b496964dae6097cc510cbb2f',
      adTypes: [AppodealAdType.BANNER, AppodealAdType.INTERSTITIAL, AppodealAdType.REWARDED],
      testMode: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Appodeal Example App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Check: Is Interstitial Ad loaded?'),
              onPressed: () async {
                var status = await Appodeal.isLoaded(AppodealAdType.INTERSTITIAL);
                print(status);
              },
            ),

            RaisedButton(
              child: Text('Show Interstitial Ad'),
              onPressed: () async {
                var status = await Appodeal.show(AppodealAdType.INTERSTITIAL);
                print(status);
              },
            ),

            RaisedButton(
              child: Text('Check: Is Reward Ad loaded?'),
              onPressed: () async {
                var status = await Appodeal.isLoaded(AppodealAdType.REWARDED);
                print(status);
              },
            ),

            RaisedButton(
              child: Text('Show Reward Ad'),
              onPressed: () async {
                var status = await Appodeal.show(AppodealAdType.REWARDED);
                print(status);
              },
            ),

            AppodealBanner()
          ],
        ),
      ),
    );
  }
}