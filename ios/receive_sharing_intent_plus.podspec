#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint receive_sharing_intent_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'receive_sharing_intent_plus'
  s.version          = '1.0.1'
  s.summary          = 'A Flutter plugin to Unlock seamless content sharing in your apps with text, photos, and URLs.'
  s.description      = <<-DESC
Unlock seamless content sharing in your Flutter apps with text, photos, and URLs - one plugin away.
                       DESC
  s.homepage         = 'https://outdatedguy.rocks'
  s.license          = { :file => '../LICENSE', :type => 'BSD-3-Clause' }
  s.author           = { 'OutdatedGuy' => 'everythingoutdated@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
