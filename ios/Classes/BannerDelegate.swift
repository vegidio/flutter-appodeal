//
//  BannerDelegate.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-31.
//

import Appodeal
import Foundation

extension SwiftAppodealFlutterPlugin: AppodealBannerViewDelegate {
    public func bannerViewDidLoadAd(_ bannerView: APDBannerView, isPrecache precache: Bool) {
        channel?.invokeMethod("onBannerLoaded", arguments: nil)
    }

    public func bannerView(_ bannerView: APDBannerView, didFailToLoadAdWithError error: Error) {
        channel?.invokeMethod("onBannerFailedToLoad", arguments: nil)
    }

    public func bannerViewDidInteract(_ bannerView: APDBannerView) {
        channel?.invokeMethod("onBannerClicked", arguments: nil)
    }

    public func bannerViewDidShow(_ bannerView: APDBannerView) {
        channel?.invokeMethod("onBannerShown", arguments: nil)
    }

    public func bannerViewExpired(_ bannerView: APDBannerView) {
        channel?.invokeMethod("onBannerExpired", arguments: nil)
    }
}
