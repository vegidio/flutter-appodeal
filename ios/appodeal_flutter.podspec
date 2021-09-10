#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint appodeal_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'appodeal_flutter'
  s.version          = '1.1.1'
  s.summary          = 'A Flutter plugin to display ads from Appodeal.'
  s.description      = <<-DESC
A Flutter plugin to display ads from Appodeal; it supports consent dialog to track users.
                       DESC
  s.homepage         = 'https://pub.dev/packages/appodeal_flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Vinicius Egidio' => 'me@vinicius.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  s.static_framework = true

  # Appodeal Dependencies
  s.dependency 'APDAdColonyAdapter', '2.10.2.1'
  s.dependency 'APDAmazonAdsAdapter', '2.10.2.1'
  s.dependency 'APDAppLovinAdapter', '2.10.2.1'
  s.dependency 'APDBidMachineAdapter', '2.10.2.2'
  s.dependency 'APDChartboostAdapter', '2.10.2.1'
  s.dependency 'APDFacebookAudienceAdapter', '2.10.2.1'
  s.dependency 'APDGoogleAdMobAdapter', '2.10.2.2'
  s.dependency 'APDInMobiAdapter', '2.10.2.1'
  s.dependency 'APDIronSourceAdapter', '2.10.2.2'
  s.dependency 'APDMintegralAdapter', '2.10.2.1'
  s.dependency 'APDMyTargetAdapter', '2.10.2.1'
  s.dependency 'APDOguryAdapter', '2.10.2.1'
  s.dependency 'APDSmaatoAdapter', '2.10.2.1'
  s.dependency 'APDStartAppAdapter', '2.10.2.2'
  s.dependency 'APDTapjoyAdapter', '2.10.2.1'
  s.dependency 'APDTwitterMoPubAdapter', '2.10.2.1'
  s.dependency 'APDUnityAdapter', '2.10.2.1'
  s.dependency 'APDVungleAdapter', '2.10.2.2'
  s.dependency 'APDYandexAdapter', '2.10.2.2'

  # Consent Manager Dependency
  s.dependency 'StackConsentManager', '1.0.1'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end