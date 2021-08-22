//
//  BannerDelegate.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-31.
//

import Appodeal
import Foundation

/**
 For reference, Appodeal API design sucks. Why use the same type of delegate for two different ad types?! It forces the
 developer to use convoluted code checks to verify if the event that we are receiving is for a Banner or MREC ad!
 */
extension SwiftAppodealFlutterPlugin: AppodealBannerViewDelegate {
    public func bannerViewDidLoadAd(_ banner: AppodealBannerView, isPrecache _: Bool) {
        channel?.invokeMethod(banner is AppodealMRECView ? "onMrecLoaded" : "onBannerLoaded", arguments: nil)
    }

    public func bannerView(_ banner: AppodealBannerView, didFailToLoadAdWithError _: Error) {
        channel?.invokeMethod(
            banner is AppodealMRECView ? "onMrecFailedToLoad" : "onBannerFailedToLoad",
            arguments: nil
        )
    }

    public func bannerViewDidInteract(_ banner: AppodealBannerView) {
        channel?.invokeMethod(banner is AppodealMRECView ? "onMrecClicked" : "onBannerClicked", arguments: nil)
    }

    public func bannerViewDidShow(_ banner: AppodealBannerView) {
        channel?.invokeMethod(banner is AppodealMRECView ? "onMrecShown" : "onBannerShown", arguments: nil)
    }

    public func bannerViewExpired(_ banner: AppodealBannerView) {
        channel?.invokeMethod(banner is AppodealMRECView ? "onMrecExpired" : "onBannerExpired", arguments: nil)
    }
}
