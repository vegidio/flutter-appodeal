package io.vinicius.appodeal_flutter

import com.appodeal.ads.RewardedVideoCallbacks
import io.flutter.plugin.common.MethodChannel

fun rewardedCallback(channel: MethodChannel): RewardedVideoCallbacks {
    return object : RewardedVideoCallbacks {
        override fun onRewardedVideoLoaded(isPrecache: Boolean) {
            channel.invokeMethod("onRewardedVideoLoaded", null)
        }

        override fun onRewardedVideoFailedToLoad() {
            channel.invokeMethod("onRewardedVideoFailedToLoad", null)
        }

        override fun onRewardedVideoShown() {
            channel.invokeMethod("onRewardedVideoShown", null)
        }

        override fun onRewardedVideoShowFailed() {
            channel.invokeMethod("onRewardedVideoShowFailed", null)
        }

        override fun onRewardedVideoFinished(p0: Double, p1: String?) {
            channel.invokeMethod("onRewardedVideoFinished", null)
        }

        override fun onRewardedVideoClosed(p0: Boolean) {
            channel.invokeMethod("onRewardedVideoClosed", null)
        }

        override fun onRewardedVideoExpired() {
            channel.invokeMethod("onRewardedVideoExpired", null)
        }

        override fun onRewardedVideoClicked() {
            channel.invokeMethod("onRewardedVideoClicked", null)
        }
    }
}