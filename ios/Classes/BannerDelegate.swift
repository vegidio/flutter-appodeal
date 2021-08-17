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

    public func mrecViewDidLoadAd(_: AppodealMRECView, isPrecache _: Bool) {
        channel?.invokeMethod("onMrecLoaded", arguments: nil)
    }

    public func mrecView(_: AppodealMRECView, didFailToLoadAdWithError _: Error) {
        channel?.invokeMethod("onMrecFailedToLoad", arguments: nil)
    }

    public func mrecViewDidInteract(_: AppodealMRECView) {
        channel?.invokeMethod("onMrecClicked", arguments: nil)
    }

    public func mrecViewDidShow(_: AppodealMRECView) {
        channel?.invokeMethod("onMrecShown", arguments: nil)
    }

    public func mrecViewExpired(_: AppodealMRECView) {
        channel?.invokeMethod("onMrecExpired", arguments: nil)
    }
}
