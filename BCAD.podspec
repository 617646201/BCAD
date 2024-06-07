#
# Be sure to run `pod lib lint BCAD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BCAD'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BCAD.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/617646201/BCAD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xxx' => 'xxx@qq.com' }
  s.source           = { :git => 'https://github.com/617646201/BCAD.git', :tag => s.version.to_s }


  s.ios.deployment_target = '14.0'
  s.source_files = 'BCAD/Classes/**/*'
  s.static_framework = true
  
  s.dependency 'Ads-CN-Beta'
  
  s.dependency 'UMCommon'
  s.dependency 'UMDevice'
  s.dependency 'UMAPM'
  
  s.ios.vendored_frameworks = 'BCAD.framework'
  
end
