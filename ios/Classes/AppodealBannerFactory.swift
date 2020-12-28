//
//  AppodealBannerFactory.swift
//  appodeal_flutter
//
//  Created by Vinicius Egidio on 2020-08-28.
//

import Appodeal
import Flutter
import Foundation

class AppodealBannerFactory: NSObject, FlutterPlatformViewFactory {
    var instance: SwiftAppodealFlutterPlugin

    init(instance: SwiftAppodealFlutterPlugin) {
        self.instance = instance
    }

    func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments args: Any?) -> FlutterPlatformView {
        var placementName: String?
        if let argsDict = args as? [String: Any] {
            placementName = argsDict["placementName"] as? String
        }

        return AppodealBannerView(instance: instance, placementName: placementName)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    // MARK: - AppodealBannerView

    class AppodealBannerView: NSObject, FlutterPlatformView {
        var instance: SwiftAppodealFlutterPlugin
        var placementName: String?

        init(instance: SwiftAppodealFlutterPlugin, placementName: String?) {
            self.instance = instance
            self.placementName = placementName
        }

        func view() -> UIView {
            let banner = APDBannerView()
            banner.delegate = instance
            banner.placement = placementName
            banner.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
            banner.loadAd()

            return banner
        }
    }
}
