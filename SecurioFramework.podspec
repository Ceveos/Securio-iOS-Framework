#
# Be sure to run `pod lib lint SecurioFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SecurioFramework'
  s.version          = '0.1.1'
  s.summary          = 'Easy to implement server-side iAP security'
  s.swift_versions   = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Securio allows you to have all the benefits of having server-side iap verification with none of the work of setting your own server up.
With the power of RSA Cryptography and spoofing detection, you can ensure iap's can't be spoofed by the tools pirates are most likely to use.
                      DESC

  s.homepage         = 'https://securio.app'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alex Casasola' => 'alex@casasola.dev' }
  s.source           = { :git => 'https://github.com/Cryonis/Securio-iOS-Framework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.3'

  s.source_files = 'SecurioFramework/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SecurioFramework' => ['SecurioFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Moya', '~> 13.0'
  s.dependency 'SwiftyRSA'
end
