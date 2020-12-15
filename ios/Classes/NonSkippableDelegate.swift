//
//  NonSkippableDelegate.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-31.
//

import Appodeal
import Foundation

extension SwiftAppodealFlutterPlugin: AppodealNonSkippableVideoDelegate {
    public func nonSkippableVideoDidLoadAdIsPrecache(_: Bool) {
        channel?.invokeMethod("onNonSkippableVideoLoaded", arguments: nil)
    }

    public func nonSkippableVideoDidFailToLoadAd() {
        channel?.invokeMethod("onNonSkippableVideoFailedToLoad", arguments: nil)
    }

    public func nonSkippableVideoDidPresent() {
        channel?.invokeMethod("onNonSkippableVideoShown", arguments: nil)
    }

    public func nonSkippableVideoDidFailToPresentWithError(_: Error) {
        channel?.invokeMethod("onNonSkippableVideoShowFailed", arguments: nil)
    }

    public func nonSkippableVideoDidFinish() {
        channel?.invokeMethod("onNonSkippableVideoFinished", arguments: nil)
    }

    public func nonSkippableVideoWillDismissAndWasFullyWatched(_: Bool) {
        channel?.invokeMethod("onNonSkippableVideoClosed", arguments: nil)
    }

    public func nonSkippableVideoDidExpired() {
        channel?.invokeMethod("onNonSkippableVideoExpired", arguments: nil)
    }
}
