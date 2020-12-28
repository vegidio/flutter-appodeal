//
//  BannerDelegate.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-31.
//

import Appodeal
import Foundation

extension SwiftAppodealFlutterPlugin: AppodealBannerViewDelegate {
    public func bannerViewDidLoadAd(_: AppodealBannerView, isPrecache _: Bool) {
        channel?.invokeMethod("onBannerLoaded", arguments: nil)
    }

    public func bannerView(_: AppodealBannerView, didFailToLoadAdWithError _: Error) {
        channel?.invokeMethod("onBannerFailedToLoad", arguments: nil)
    }

    public func bannerViewDidInteract(_: AppodealBannerView) {
        channel?.invokeMethod("onBannerClicked", arguments: nil)
    }

    public func bannerViewDidShow(_: AppodealBannerView) {
        channel?.invokeMethod("onBannerShown", arguments: nil)
    }

    public func bannerViewExpired(_: AppodealBannerView) {
        channel?.invokeMethod("onBannerExpired", arguments: nil)
    }
}
