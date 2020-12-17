package io.vinicius.appodeal_flutter

import com.appodeal.ads.BannerCallbacks
import io.flutter.plugin.common.MethodChannel

fun bannerCallback(channel: MethodChannel): BannerCallbacks {
    return object : BannerCallbacks {
        override fun onBannerLoaded(p0: Int, p1: Boolean) {
            channel.invokeMethod("onBannerLoaded", null)
        }

        override fun onBannerFailedToLoad() {
            channel.invokeMethod("onBannerFailedToLoad", null)
        }

        override fun onBannerShown() {
            channel.invokeMethod("onBannerShown", null)
        }

        override fun onBannerShowFailed() {
            // Not implemented for the sake of consistency with iOS
        }

        override fun onBannerClicked() {
            channel.invokeMethod("onBannerClicked", null)
        }

        override fun onBannerExpired() {
            channel.invokeMethod("onBannerExpired", null)
        }
    }
}