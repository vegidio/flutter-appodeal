#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint appodeal_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'appodeal_flutter'
  s.version          = '0.2.1'
  s.summary          = 'A Flutter plugin to display ads from Appodeal.'
  s.description      = <<-DESC
A Flutter plugin to display ads from Appodeal; it supports the new reqs for iOS 14+ and GDPR/CCPA consent.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Vinicius Egidio' => 'me@vinicius.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.static_framework = true

  # Appodeal Dependencies
  s.dependency 'APDAdColonyAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDAmazonAdsAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDAppLovinAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDAppodealAdExchangeAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDChartboostAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDFacebookAudienceAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDGoogleAdMobAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDInMobiAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDInnerActiveAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDIronSourceAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDMintegralAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDMyTargetAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDOguryAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDOpenXAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDPubnativeAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDSmaatoAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDStartAppAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDTapjoyAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDUnityAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDVungleAdapter', '2.7.3.1-Beta' 
  s.dependency 'APDYandexAdapter', '2.7.3.1-Beta'

  # Consent Manager Dependency
  s.dependency 'StackConsentManager', '1.0.1'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
