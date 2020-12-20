import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealBanner extends StatelessWidget {
  final String placementName;

  AppodealBanner ({ this.placementName });

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> args = {
      "placementName": this.placementName
    };
    return Container(
      width: 320,
      height: 50,
      child: Platform.isIOS
        ? UiKitView(
            viewType: 'plugins.io.vinicius.appodeal/banner',
            creationParams: args,
            creationParamsCodec: const StandardMessageCodec(),
          )
        : AndroidView(
            viewType: 'plugins.io.vinicius.appodeal/banner',
            creationParams: args,
            creationParamsCodec: const StandardMessageCodec(),
          ),
    );
  }
}
