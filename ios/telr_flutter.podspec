#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint telr_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'telr_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.3'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  # TelrSDk
  s.preserve_paths = 'TelrSDK.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework TelrSDK' }
  s.vendored_frameworks = 'TelrSDK.framework','AEXML.framework','SwiftyXMLParser.framework'

  # AXML SDK
  # s.preserve_paths = 'AEXML.framework'
  # s.xcconfig = { 'OTHER_LDFLAGS' => '-framework AEXML' }
  # s.vendored_frameworks = 'AEXML.framework'
  # # # SwiftyXMLParser SDK
  # s.preserve_paths = 'SwiftyXMLParser.framework'
  # s.xcconfig = { 'OTHER_LDFLAGS' => '-framework SwiftyXMLParser' }
  # s.vendored_frameworks = 'SwiftyXMLParser.framework'
end
