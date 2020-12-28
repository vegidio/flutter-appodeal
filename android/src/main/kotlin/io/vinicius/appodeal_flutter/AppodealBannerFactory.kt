package io.vinicius.appodeal_flutter

import android.app.Activity
import android.content.Context
import android.view.View
import com.appodeal.ads.Appodeal
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AppodealBannerFactory(private val activity: Activity, private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView =
        AppodealBannerView(activity, messenger, viewId, args)

    class AppodealBannerView(activity: Activity, messenger: BinaryMessenger, id: Int, args: Any?) :
        PlatformView, MethodChannel.MethodCallHandler {
        private val arguments = args as Map<*, *>
        private val placementName = arguments["placementName"] as? String

        private val bannerView = Appodeal.getBannerView(activity)
        private val channel = MethodChannel(messenger, "plugins.io.vinicius.appodeal/banner_$id")

        init {
            if (placementName !== null) {
                Appodeal.show(activity, Appodeal.BANNER_VIEW, placementName)
            } else {
                Appodeal.show(activity, Appodeal.BANNER_VIEW)
            }

            channel.setMethodCallHandler(this)
        }

        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
            when (call.method) {
                else -> result.notImplemented()
            }
        }

        override fun getView(): View = bannerView
        override fun dispose() {}
    }
}