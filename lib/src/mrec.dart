import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealMrec extends StatelessWidget {
  final Map<String, dynamic> _args = {};

  AppodealMrec({String? placementName}) {
    this._args["placementName"] = placementName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      child: Platform.isIOS
          ? UiKitView(
              viewType: 'plugins.io.vinicius.appodeal/mrec',
              creationParams: this._args,
              creationParamsCodec: const StandardMessageCodec(),
            )
          : AndroidView(
              viewType: 'plugins.io.vinicius.appodeal/mrec',
              creationParams: this._args,
              creationParamsCodec: const StandardMessageCodec(),
            ),
    );
  }
}
