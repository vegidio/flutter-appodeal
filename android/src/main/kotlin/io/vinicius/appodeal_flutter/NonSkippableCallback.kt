package io.vinicius.appodeal_flutter

import com.appodeal.ads.NonSkippableVideoCallbacks
import io.flutter.plugin.common.MethodChannel

fun nonSkippableCallback(channel: MethodChannel): NonSkippableVideoCallbacks {
    return object : NonSkippableVideoCallbacks {
        override fun onNonSkippableVideoLoaded(p0: Boolean) {
            channel.invokeMethod("onNonSkippableVideoLoaded", null)
        }

        override fun onNonSkippableVideoFailedToLoad() {
            channel.invokeMethod("onNonSkippableVideoFailedToLoad", null)
        }

        override fun onNonSkippableVideoShown() {
            channel.invokeMethod("onNonSkippableVideoShown", null)
        }

        override fun onNonSkippableVideoShowFailed() {
            channel.invokeMethod("onNonSkippableVideoShowFailed", null)
        }

        override fun onNonSkippableVideoFinished() {
            channel.invokeMethod("onNonSkippableVideoFinished", null)
        }

        override fun onNonSkippableVideoClosed(p0: Boolean) {
            channel.invokeMethod("onNonSkippableVideoClosed", null)
        }

        override fun onNonSkippableVideoExpired() {
            channel.invokeMethod("onNonSkippableVideoExpired", null)
        }
    }
}