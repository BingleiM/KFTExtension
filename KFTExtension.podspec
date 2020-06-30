Pod::Spec.new do |s|
s.authors      = "BingleiM"
#名称
s.name         = "KFTExtension"
#版本号
s.version      = "1.0.7"
#简介
s.summary      = "Extension"
s.description  = <<-DESC
                        常用类的一些扩展方法封装
                 DESC
#项目主页地址
s.homepage     = "https://github.com/BingleiM/KFTExtension.git"
#许可证
s.license      = { :type => 'MIT', :file => 'LICENSE' }
#作者
s.author       = { "KFTPay" => "houdaoc@163.com" }
s.source       = { :git => "https://github.com/BingleiM/KFTExtension.git", :tag => s.version }
#s.source_files = "KFTExtension/KFTExtension.framework/**"
s.requires_arc = true
#支持最小系统版本
s.ios.deployment_target = '8.0'
#依赖库
#s.frameworks = "CoreTelephony", "AssetsLibrary", "CoreMedia", "AVFoundation", "WebKit", "SystemConfiguration"
s.frameworks = "Foundation", "UIKit"
#SDK路径（因为传的是静态库，这个必须要）
s.vendored_frameworks = "KFTExtension/KFTExtension.framework"
#s.source_files = 'KFTExtension/Classes/**/**/*.{h,m}'
#s.public_header_files = 'KFTExtension/Classes/*.h'


end
