import Appodeal
import AppTrackingTransparency
import Flutter
import StackConsentManager
import UIKit

public class SwiftAppodealFlutterPlugin: NSObject, FlutterPlugin {
    internal var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftAppodealFlutterPlugin()
        instance.channel = FlutterMethodChannel(name: "appodeal_flutter", binaryMessenger: registrar.messenger())

        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
        registrar.register(AppodealBannerFactory(instance: instance), withId: "plugins.io.vinicius.appodeal/banner")
        registrar.register(AppodealMrecFactory(instance: instance), withId: "plugins.io.vinicius.appodeal/mrec")
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize": initialize(call, result)
        case "setAutoCache": setAutoCache(call, result)
        case "cache": cache(call, result)
        case "isReadyForShow": isReadyForShow(call, result)
        case "canShow": canShow(call, result)
        case "show": show(call, result)

        // Consent Manager
        case "fetchConsentInfo": fetchConsentInfo(call, result)
        case "shouldShowConsent": shouldShowConsent(call, result)
        case "requestConsentAuthorization": requestConsentAuthorization(result)

        // Permissions
        case "requestIOSTrackingAuthorization": requestIOSTrackingAuthorization(result)
        case "setIOSLocationTracking": setIOSLocationTracking(call, result)

        default: result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Appodeal

    private func initialize(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let appKey = args["iosAppKey"] as! String
        let hasConsent = args["hasConsent"] as! Bool
        let adTypes = args["adTypes"] as! [Int]
        let testMode = args["testMode"] as! Bool
        let verbose = args["verbose"] as! Bool

        // Registering callbacks
        setCallbacks()

        let ads = AppodealAdType(rawValue: adTypes.reduce(0) { $0 | getAdType(adId: $1).rawValue })
        Appodeal.setTestingEnabled(testMode)
        Appodeal.initialize(withApiKey: appKey, types: ads, hasConsent: hasConsent)

        if verbose {
            Appodeal.setLogLevel(APDLogLevel.verbose)
        }

        result(nil)
    }

    private func setAutoCache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        let autoCache = args["autoCache"] as! Bool

        Appodeal.setAutocache(autoCache, types: adType)

        result(nil)
    }

    private func cache(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)

        Appodeal.cacheAd(adType)

        result(nil)
    }

    private func isReadyForShow(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getShowStyle(adType: getAdType(adId: args["adType"] as! Int))

        result(Appodeal.isReadyForShow(with: adType))
    }

    private func canShow(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getAdType(adId: args["adType"] as! Int)
        let placementName = args["placementName"] as? String ?? ""

        result(Appodeal.canShow(adType, forPlacement: placementName))
    }

    private func show(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let adType = getShowStyle(adType: getAdType(adId: args["adType"] as! Int))
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let placementName = args["placementName"] as? String {
            result(Appodeal.showAd(adType, forPlacement: placementName, rootViewController: rootViewController))
        } else {
            result(Appodeal.showAd(adType, rootViewController: rootViewController))
        }
    }

    private func setCallbacks() {
        // Banner callbacks are registered in AppodealBannerFactory > AppodealBannerView
        Appodeal.setInterstitialDelegate(self)
        Appodeal.setRewardedVideoDelegate(self)
        Appodeal.setNonSkippableVideoDelegate(self)
    }

    // MARK: - Consent Manager

    private func fetchConsentInfo(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let appKey = args["iosAppKey"] as! String

        STKConsentManager.shared().synchronize(withAppKey: appKey) { error in
            if error == nil {
                result([
                    "acceptedVendors": [],
                    "status": STKConsentManager.shared().consentStatus.rawValue,
                    "zone": STKConsentManager.shared().regulation.rawValue,
                ])
            } else {
                result(FlutterError(code: "CONSENT_INFO_ERROR", message: error!.localizedDescription, details: nil))
            }
        }
    }

    private func shouldShowConsent(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let appKey = args["iosAppKey"] as! String

        STKConsentManager.shared().synchronize(withAppKey: appKey) { error in
            if error == nil {
                result(STKConsentManager.shared().shouldShowConsentDialog == .true)
            } else {
                result(FlutterError(code: "CONSENT_CHECK_ERROR", message: error!.localizedDescription, details: nil))
            }
        }
    }

    private func requestConsentAuthorization(_ result: @escaping FlutterResult) {
        STKConsentManager.shared().loadConsentDialog { error in
            if error == nil {
                let controller = UIApplication.shared.keyWindow?.rootViewController
                STKConsentManager.shared().showConsentDialog(fromRootViewController: controller!, delegate: nil)
                result(nil)
            } else {
                result(FlutterError(code: "CONSENT_WINDOW_ERROR", message: error!.localizedDescription, details: nil))
            }
        }
    }

    // MARK: - Permissions

    private func requestIOSTrackingAuthorization(_ result: @escaping FlutterResult) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                result(status == .authorized)
            }
        } else {
            result(true)
        }
    }

    private func setIOSLocationTracking(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        let enabled = args["enabled"] as! Bool

        Appodeal.setLocationTracking(enabled)
        result(nil)
    }

    // MARK: - Helper Methods

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
        case 6: return .MREC
        default: return AppodealAdType(rawValue: 0)
        }
    }
}
