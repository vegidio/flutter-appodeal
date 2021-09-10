import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealBanner extends StatelessWidget {
  final Map<String, dynamic> _args = {};

  AppodealBanner({Key? key, String? placementName}) : super(key: key) {
    _args["placementName"] = placementName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 50,
      child: Platform.isIOS
          ? UiKitView(
              key: UniqueKey(),
              viewType: 'plugins.io.vinicius.appodeal/banner',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            )
          : AndroidView(
              key: UniqueKey(),
              viewType: 'plugins.io.vinicius.appodeal/banner',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            ),
    );
  }
}
