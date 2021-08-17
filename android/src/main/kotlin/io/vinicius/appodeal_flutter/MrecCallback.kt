package io.vinicius.appodeal_flutter

import com.appodeal.ads.MrecCallbacks
import io.flutter.plugin.common.MethodChannel

fun mrecCallback(channel: MethodChannel): MrecCallbacks {
    return object : MrecCallbacks {
        override fun onMrecLoaded(p0: Boolean) {
            channel.invokeMethod("onMrecLoaded", null)
        }

        override fun onMrecFailedToLoad() {
            channel.invokeMethod("onMrecFailedToLoad", null)
        }

        override fun onMrecShown() {
            channel.invokeMethod("onMrecShown", null)
        }

        override fun onMrecShowFailed() {
            // Not implemented for the sake of consistency with iOS
        }

        override fun onMrecClicked() {
            channel.invokeMethod("onMrecClicked", null)
        }

        override fun onMrecExpired() {
            channel.invokeMethod("onMrecExpired", null)
        }
    }
}