//
//  AppodealInterstitialDelegate.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-31.
//

import Appodeal
import Foundation

extension SwiftAppodealFlutterPlugin: AppodealInterstitialDelegate {
    public func interstitialDidLoadAdIsPrecache(_: Bool) {
        channel?.invokeMethod("onInterstitialLoaded", arguments: nil)
    }

    public func interstitialDidFailToLoadAd() {
        channel?.invokeMethod("onInterstitialFailedToLoad", arguments: nil)
    }

    public func interstitialWillPresent() {
        channel?.invokeMethod("onInterstitialShown", arguments: nil)
    }

    public func interstitialDidFailToPresent() {
        channel?.invokeMethod("onInterstitialShowFailed", arguments: nil)
    }

    public func interstitialDidClick() {
        channel?.invokeMethod("onInterstitialClicked", arguments: nil)
    }

    public func interstitialDidDismiss() {
        channel?.invokeMethod("onInterstitialClosed", arguments: nil)
    }

    public func interstitialDidExpired() {
        channel?.invokeMethod("onInterstitialExpired", arguments: nil)
    }
}
