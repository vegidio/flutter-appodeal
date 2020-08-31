//
//  BannerDelegate.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-31.
//

import Appodeal
import Foundation

extension SwiftAppodealFlutterPlugin: AppodealBannerDelegate
{
    public func bannerDidLoadAdIsPrecache(_ precache: Bool) {
        channel?.invokeMethod("onBannerLoaded", arguments: nil)
    }
    
    public func bannerDidFailToLoadAd() {
        channel?.invokeMethod("onBannerFailedToLoad", arguments: nil)
    }
    
    public func bannerDidShow() {
        channel?.invokeMethod("onBannerShown", arguments: nil)
    }
    
    public func bannerDidClick() {
        channel?.invokeMethod("onBannerClicked", arguments: nil)
    }
    
    public func bannerDidExpired() {
        channel?.invokeMethod("onBannerExpired", arguments: nil)
    }
}
