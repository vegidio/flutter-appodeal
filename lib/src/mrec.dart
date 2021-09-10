import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealMrec extends StatelessWidget {
  final Map<String, dynamic> _args = {};

  AppodealMrec({Key? key, String? placementName}) : super(key: key) {
    _args["placementName"] = placementName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 250,
      child: Platform.isIOS
          ? UiKitView(
              key: UniqueKey(),
              viewType: 'plugins.io.vinicius.appodeal/mrec',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            )
          : AndroidView(
              key: UniqueKey(),
              viewType: 'plugins.io.vinicius.appodeal/mrec',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            ),
    );
  }
}
