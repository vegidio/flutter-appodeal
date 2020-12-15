//
//  RewardDelegate.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-31.
//

import Appodeal
import Foundation

extension SwiftAppodealFlutterPlugin: AppodealRewardedVideoDelegate {
    public func rewardedVideoDidLoadAdIsPrecache(_: Bool) {
        channel?.invokeMethod("onRewardedVideoLoaded", arguments: nil)
    }

    public func rewardedVideoDidFailToLoadAd() {
        channel?.invokeMethod("onRewardedVideoFailedToLoad", arguments: nil)
    }

    public func rewardedVideoDidPresent() {
        channel?.invokeMethod("onRewardedVideoShown", arguments: nil)
    }

    public func rewardedVideoDidFailToPresentWithError(_: Error) {
        channel?.invokeMethod("onRewardedVideoShowFailed", arguments: nil)
    }

    public func rewardedVideoDidFinish(_: Float, name _: String?) {
        channel?.invokeMethod("onRewardedVideoFinished", arguments: nil)
    }

    public func rewardedVideoWillDismissAndWasFullyWatched(_: Bool) {
        channel?.invokeMethod("onRewardedVideoClosed", arguments: nil)
    }

    public func rewardedVideoDidExpired() {
        channel?.invokeMethod("onRewardedVideoExpired", arguments: nil)
    }

    public func rewardedVideoDidClick() {
        channel?.invokeMethod("onRewardedVideoClicked", arguments: nil)
    }
}
