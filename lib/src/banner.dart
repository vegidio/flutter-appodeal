import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 50,
      child: Platform.isIOS ?
        UiKitView(
          viewType: 'plugins.io.vinicius.appodeal/banner',
          creationParams: {},
          creationParamsCodec: const StandardMessageCodec(),
        ) :
        AndroidView(
          viewType: 'plugins.io.vinicius.appodeal/banner',
          creationParams: {},
          creationParamsCodec: const StandardMessageCodec(),
        ),
    );
  }
}