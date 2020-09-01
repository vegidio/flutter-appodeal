package io.vinicius.appodeal_flutter

import android.app.Activity
import androidx.annotation.NonNull
import com.appodeal.ads.Appodeal
import com.appodeal.ads.BannerCallbacks
import com.appodeal.ads.InterstitialCallbacks
import com.appodeal.ads.NonSkippableVideoCallbacks
import com.appodeal.ads.RewardedVideoCallbacks
import com.explorestack.consent.Consent
import com.explorestack.consent.Consent.ShouldShow
import com.explorestack.consent.ConsentForm
import com.explorestack.consent.ConsentFormListener
import com.explorestack.consent.ConsentInfoUpdateListener
import com.explorestack.consent.ConsentManager
import com.explorestack.consent.exception.ConsentManagerException
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class AppodealFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware
{
    private lateinit var activity: Activity
    private lateinit var channel: MethodChannel
    private lateinit var pluginBinding: FlutterPlugin.FlutterPluginBinding

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = flutterPluginBinding
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "appodeal_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "initialize" -> initialize(call, result)
            "isLoaded" -> isLoaded(call, result)
            "show" -> show(activity, call, result)

            "fetchConsentInfo" -> fetchConsentInfo(call, result)
            "shouldShowConsent" -> shouldShowConsent(result)
            "requestConsentAuthorization" -> requestConsentAuthorization(result)

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity

        pluginBinding.platformViewRegistry.registerViewFactory(
                "plugins.io.vinicius.appodeal/banner",
                AppodealBannerFactory(activity, pluginBinding.binaryMessenger)
        )
    }

    override fun onDetachedFromActivityForConfigChanges() {}
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
    override fun onDetachedFromActivity() {}

    // region - Appodeal
    private fun initialize(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val appKey = args["androidAppKey"] as String
        val hasConsent = args["hasConsent"] as Boolean
        val adTypes = args["adTypes"] as List<Int>
        val testMode = args["testMode"] as Boolean

        // Registering callbacks
        setCallbacks()

        val ads = adTypes.fold(0) { acc, value -> acc or getAdType(value) }
        Appodeal.setTesting(testMode)
        Appodeal.initialize(activity, appKey, ads, hasConsent)

        result.success(null)
    }

    private fun isLoaded(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)

        result.success(Appodeal.isLoaded(adType))
    }

    private fun show(activity: Activity, call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)

        result.success(Appodeal.show(activity, adType))
    }
    // endregion

    // region - Callbacks
    private fun setCallbacks() {
        Appodeal.setBannerCallbacks(object : BannerCallbacks {
            override fun onBannerLoaded(p0: Int, p1: Boolean) {
                channel.invokeMethod("onBannerLoaded", null)
            }

            override fun onBannerFailedToLoad() {
                channel.invokeMethod("onBannerFailedToLoad", null)
            }

            override fun onBannerShown() {
                channel.invokeMethod("onBannerShown", null)
            }

            override fun onBannerShowFailed() {
                // Not implemented for the sake of consistency with iOS
            }

            override fun onBannerClicked() {
                channel.invokeMethod("onBannerClicked", null)
            }

            override fun onBannerExpired() {
                channel.invokeMethod("onBannerExpired", null)
            }
        })

        Appodeal.setInterstitialCallbacks(object : InterstitialCallbacks {
            override fun onInterstitialLoaded(isPrecache: Boolean) {
                channel.invokeMethod("onInterstitialLoaded", null)
            }

            override fun onInterstitialFailedToLoad() {
                channel.invokeMethod("onInterstitialFailedToLoad", null)
            }

            override fun onInterstitialShown() {
                channel.invokeMethod("onInterstitialShown", null)
            }

            override fun onInterstitialShowFailed() {
                channel.invokeMethod("onInterstitialShowFailed", null)
            }

            override fun onInterstitialClicked() {
                channel.invokeMethod("onInterstitialClicked", null)
            }

            override fun onInterstitialClosed() {
                channel.invokeMethod("onInterstitialClosed", null)
            }

            override fun onInterstitialExpired() {
                channel.invokeMethod("onInterstitialExpired", null)
            }
        })

        Appodeal.setRewardedVideoCallbacks(object : RewardedVideoCallbacks {
            override fun onRewardedVideoLoaded(isPrecache: Boolean) {
                channel.invokeMethod("onRewardedVideoLoaded", null)
            }

            override fun onRewardedVideoFailedToLoad() {
                channel.invokeMethod("onRewardedVideoFailedToLoad", null)
            }

            override fun onRewardedVideoShown() {
                channel.invokeMethod("onRewardedVideoShown", null)
            }

            override fun onRewardedVideoShowFailed() {
                channel.invokeMethod("onRewardedVideoShowFailed", null)
            }

            override fun onRewardedVideoFinished(p0: Double, p1: String?) {
                channel.invokeMethod("onRewardedVideoFinished", null)
            }

            override fun onRewardedVideoClosed(p0: Boolean) {
                channel.invokeMethod("onRewardedVideoClosed", null)
            }

            override fun onRewardedVideoExpired() {
                channel.invokeMethod("onRewardedVideoExpired", null)
            }

            override fun onRewardedVideoClicked() {
                channel.invokeMethod("onRewardedVideoClicked", null)
            }
        })

        Appodeal.setNonSkippableVideoCallbacks(object : NonSkippableVideoCallbacks {
            override fun onNonSkippableVideoLoaded(p0: Boolean) {
                channel.invokeMethod("onNonSkippableVideoLoaded", null)
            }

            override fun onNonSkippableVideoFailedToLoad() {
                channel.invokeMethod("onNonSkippableVideoFailedToLoad", null)
            }

            override fun onNonSkippableVideoShown() {
                channel.invokeMethod("onNonSkippableVideoShown", null)
            }

            override fun onNonSkippableVideoShowFailed() {
                channel.invokeMethod("onNonSkippableVideoShowFailed", null)
            }

            override fun onNonSkippableVideoFinished() {
                channel.invokeMethod("onNonSkippableVideoFinished", null)
            }

            override fun onNonSkippableVideoClosed(p0: Boolean) {
                channel.invokeMethod("onNonSkippableVideoClosed", null)
            }

            override fun onNonSkippableVideoExpired() {
                channel.invokeMethod("onNonSkippableVideoExpired", null)
            }
        })
    }
    // endregion

    // region - Consent Manager
    private fun fetchConsentInfo(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val appKey = args["androidAppKey"] as String

        val consentManager = ConsentManager.getInstance(activity)
        consentManager.requestConsentInfoUpdate(appKey, object : ConsentInfoUpdateListener {
            override fun onConsentInfoUpdated(consent: Consent?) {
                if (consent == null) {
                    result.success(null)
                } else {
                    result.success(mapOf(
                            "acceptedVendors" to consent.acceptedVendors?.map { it.name },
                            "status" to consent.status.ordinal,
                            "zone" to consent.zone.ordinal
                    ))
                }
            }

            override fun onFailedToUpdateConsentInfo(exception: ConsentManagerException?) {
                result.error("CONSENT_INFO_ERROR", "Failed to fetch the consent info",
                        exception)
            }
        })
    }

    private fun shouldShowConsent(result: Result) {
        val consentManager = ConsentManager.getInstance(activity)
        val shouldShow = consentManager.shouldShowConsentDialog()

        result.success(shouldShow == ShouldShow.TRUE)
    }

    private fun requestConsentAuthorization(result: Result) {
        var consentForm: ConsentForm? = null

        consentForm = ConsentForm.Builder(activity)
                .withListener(object : ConsentFormListener {
                    override fun onConsentFormLoaded() {
                        consentForm?.showAsDialog()
                        result.success(null)
                    }

                    override fun onConsentFormError(exception: ConsentManagerException?) {
                        result.error("CONSENT_WINDOW_ERROR",
                                "Error showing the consent window", exception)
                    }

                    override fun onConsentFormOpened() {}
                    override fun onConsentFormClosed(consent: Consent?) {}
                })
                .build()

        consentForm.load()
    }
    // endregion

    // region - Helper Methods
    private fun getAdType(adId: Int): Int {
        return when (adId) {
            1 -> Appodeal.BANNER
            2 -> Appodeal.NATIVE
            3 -> Appodeal.INTERSTITIAL
            4 -> Appodeal.REWARDED_VIDEO
            5 -> Appodeal.NON_SKIPPABLE_VIDEO
            else -> Appodeal.NONE
        }
    }
    // endregion
}