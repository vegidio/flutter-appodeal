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
    func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments _: Any?) -> FlutterPlatformView {
        AppodealBannerView()
    }

    class AppodealBannerView: NSObject, FlutterPlatformView {
        func view() -> UIView {
            let banner = Appodeal.banner()
            banner?.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
            return banner ?? UIView()
        }
    }
}
