import Appodeal
import Flutter
import UIKit

public class SwiftAppodealFlutterPlugin: NSObject, FlutterPlugin
{
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "appodeal_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftAppodealFlutterPlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.register(AppodealBannerFactory(), withId: "plugins.io.vinicius.appodeal/banner")
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize": initialize(call)
        case "isLoaded": isLoaded(call, result)
        case "show": show(call, result)
        default: result(FlutterMethodNotImplemented)
        }
    }
    
    // region - Methods
    private func initialize(_ call: FlutterMethodCall) {
        let args = call.arguments as! Dictionary<String, Any>
        let appKey = args["iosAppKey"] as! String
        let adTypes = args["adTypes"] as! Array<Int>
        let testMode = args["testMode"] as! Bool
        
        let ads = AppodealAdType(rawValue: adTypes.reduce(0) { $0 | getAdType(adId: $1).rawValue })
        Appodeal.setTestingEnabled(testMode)
        Appodeal.initialize(withApiKey: appKey, types: ads, hasConsent: true)
    }
    
    private func isLoaded(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any>
        let adType = getShowStyle(adType: getAdType(adId: args["adType"] as! Int))
        
        result(Appodeal.isReadyForShow(with: adType))
    }
    
    private func show(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! Dictionary<String, Any>
        let adType = getShowStyle(adType: getAdType(adId: args["adType"] as! Int))
        
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        result(Appodeal.showAd(adType, rootViewController: rootViewController))
    }
    // endregion
    
    // region - Helper
    private func getShowStyle(adType: AppodealAdType) -> AppodealShowStyle {
        switch adType {
        case .interstitial: return .interstitial
        case .rewardedVideo: return .rewardedVideo
        case .nonSkippableVideo: return .nonSkippableVideo
        default: return AppodealShowStyle(rawValue: 0)
        }
    }
    
    private func getAdType(adId: Int) -> AppodealAdType {
        switch adId {
        case 1: return .banner
        case 2: return .nativeAd
        case 3: return .interstitial
        case 4: return .rewardedVideo
        case 5: return .nonSkippableVideo
        default: return AppodealAdType(rawValue: 0)
        }
    }
    // endregion
}
