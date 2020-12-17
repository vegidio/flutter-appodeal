package io.vinicius.appodeal_flutter

import com.appodeal.ads.InterstitialCallbacks
import io.flutter.plugin.common.MethodChannel

fun interstitialCallback(channel: MethodChannel): InterstitialCallbacks {
    return object : InterstitialCallbacks {
        override fun onInterstitialLoaded(isPrecache: Boolean) {
            channel.invokeMethod("onInterstitialLoaded", null)
        }

        override fun onInterstitialFailedToLoad() {
            channel.invokeMethod("onInterstitialFailedToLoad", null)
        }

        override fun onInterstitialShown() {
            channel.invokeMethod("onInterstitialShown", null)
        }

        override fun onInterstitialShowFailed() {
            channel.invokeMethod("onInterstitialShowFailed", null)
        }

        override fun onInterstitialClicked() {
            channel.invokeMethod("onInterstitialClicked", null)
        }

        override fun onInterstitialClosed() {
            channel.invokeMethod("onInterstitialClosed", null)
        }

        override fun onInterstitialExpired() {
            channel.invokeMethod("onInterstitialExpired", null)
        }
    }
}