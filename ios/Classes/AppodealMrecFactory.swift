//
//  AppodealMrecFactory.swift
//  appodeal_flutter
//
//  Created by Elia Bieri on 2021-08-22.
//

import Appodeal
import Flutter
import Foundation

class AppodealMrecFactory: NSObject, FlutterPlatformViewFactory {
    var instance: SwiftAppodealFlutterPlugin

    init(instance: SwiftAppodealFlutterPlugin) {
        self.instance = instance
    }

    func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments args: Any?) -> FlutterPlatformView {
        var placementName: String?
        if let argsDict = args as? [String: Any] {
            placementName = argsDict["placementName"] as? String
        }

        return AppodealMrecView(instance: instance, placementName: placementName)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    // MARK: - AppodealMrecView

    class AppodealMrecView: NSObject, FlutterPlatformView {
        var instance: SwiftAppodealFlutterPlugin
        var placementName: String?

        init(instance: SwiftAppodealFlutterPlugin, placementName: String?) {
            self.instance = instance
            self.placementName = placementName
        }

        func view() -> UIView {
            let mrec = APDMRECView()
            mrec?.delegate = instance
            mrec?.placement = placementName
            mrec?.frame = CGRect(x: 0, y: 0, width: 300, height: 250)
            mrec?.loadAd()

            return mrec ?? UIView()
        }
    }
}
