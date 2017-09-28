#
# Be sure to run `pod lib lint AWAppModelEngine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AWAppModelEngine'
  s.version          = '0.0.1'
  s.summary          = 'Distribute the UIApplicationDelegate event'

  s.description      = <<-DESC
Distribute the UIApplicationDelegate event so that the modules are processed separately
                       DESC

  s.homepage         = 'https://github.com/TryHone/AWAppModelEngine'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tryhone' => 'tryhone@gamil.com' }
  s.source           = { :git => 'https://github.com/TryHone/AWAppModelEngine.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AWAppModelEngine/Classes/**/*'
end
