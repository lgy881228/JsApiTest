#
#  Be sure to run `pod spec lint JsApiTest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


    s.name         = "JsApiTest"
    s.version      = "1.0.1"
    s.summary      = "测试模块打包和方法调用"

     s.description  = <<-DESC
      测试模块打包和方法调用针对模块化应用和功能
                     DESC

    s.homepage     = "https://github.com/JsApiTest"


   
    s.license      = { :type => "MIT", :file => "LICENSE" }

    s.requires_arc = true

    s.author             = { "lgy881228" => "510687394@qq.com" }

    s.platform     = :ios, "11.0"
    s.ios.deployment_target = "11.0"

    s.source      = { :git => 'https://github.com/lgy881228/JsApiTest.git',
  :tag => s.version.to_s }


    s.source_files  = "XEngineJsApiTestModuleTest/*.{h,m}"
    s.public_header_files = "XEngineJsApiTestModuleTest/*.h"
   # s.dependency 'AFNetworking','~> 4.0'
   # s.dependency 'JSONModel'
   # s.frameworks  = "UIKit","AVFoundation","Foundation","AFNetworking","JSONModel","CoreServices"

    s.pod_target_xcconfig = {'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}



end
