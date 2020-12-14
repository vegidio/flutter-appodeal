#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint appodeal_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'appodeal_flutter'
  s.version          = '0.3.2'
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
  s.platform = :ios, '10.0'
  s.static_framework = true

  # Appodeal Dependencies
  s.dependency 'APDAdColonyAdapter', '2.8.1.1'
  s.dependency 'APDAmazonAdsAdapter', '2.8.1.1'
  s.dependency 'APDAppLovinAdapter', '2.8.1.1'
  s.dependency 'APDBidMachineAdapter', '2.8.1.1'
  s.dependency 'APDFacebookAudienceAdapter', '2.8.1.1'
  s.dependency 'APDGoogleAdMobAdapter', '2.8.1.1'
  s.dependency 'APDIronSourceAdapter', '2.8.1.1'
  s.dependency 'APDMyTargetAdapter', '2.8.1.1'
  s.dependency 'APDOguryAdapter', '2.8.1.1'
  s.dependency 'APDSmaatoAdapter', '2.8.1.1'
  s.dependency 'APDStartAppAdapter', '2.8.1.1'
  s.dependency 'APDUnityAdapter', '2.8.1.1'
  s.dependency 'APDVungleAdapter', '2.8.1.1'
  s.dependency 'APDYandexAdapter', '2.8.1.1'

  # Consent Manager Dependency
  s.dependency 'StackConsentManager', '1.0.1'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
