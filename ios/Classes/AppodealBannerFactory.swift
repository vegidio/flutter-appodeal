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
        var placementName: String? = nil;
        if let argsDict = args as? Dictionary<String, Any> {
            placementName = argsDict["placementName"] as? String
        }

        return AppodealBannerView(instance: self.instance, placementName: placementName)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
      return FlutterStandardMessageCodec.sharedInstance()
    }

    class AppodealBannerView: NSObject, FlutterPlatformView {
        var instance: SwiftAppodealFlutterPlugin
        var placementName: String?

        init(instance: SwiftAppodealFlutterPlugin, placementName: String?) {
            self.instance = instance
            self.placementName = placementName
        }

        func view() -> UIView {
            let banner: APDBannerView! = APDBannerView.init()
            banner?.delegate = self.instance
            banner?.placement = self.placementName
            banner?.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
            banner?.loadAd()
            return banner ?? UIView()
        }
    }
}
