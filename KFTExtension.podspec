Pod::Spec.new do |s|
s.authors      = "KFTPay"
#名称
s.name         = "KFTExtension"
#版本号
s.version      = "1.0.0"
#简介
s.summary      = "快付通官方支付 SDK "
s.description  = <<-DESC
                        Copyright © 2019 深圳快付通金融网络科技有限公司.
                 DESC
#项目主页地址
s.homepage     = "https://www.kftpay.com.cn/"
#许可证
s.license      = "MIT"
#作者
s.author       = { "KFTPay" => "mabl@kftpay.com.cn" }
#项目的地址 （注意这里的tag位置，可以自己写也可以直接用s.version，但是与s.version一定要统一）
s.source       = { :git => "https://github.com/BingleiM/KFTExtension.git", :tag => s.version }
#需要包含的源文件（也是个坑）按照你的文件层级来
s.source_files = 'KFTExtension', 'KFTExtension.framework/**/*.{h}'
s.requires_arc = true
#支持最小系统版本
s.ios.deployment_target = '8.0'
#依赖库
#s.framework = "CoreTelephony", "AssetsLibrary", "CoreMedia", "AVFoundation", "WebKit", "SystemConfiguration"
s.frameworks = "Foundation", "UIKit"
#s.libraries = "c++.tbd"
#你的SDK路径（因为传的是静态库，这个必须要）
s.ios.vendored_frameworks = 'KFTExtension.framework'
#s.resource = "KFTPaySDKBundle.bundle"
#依赖的第三方
#s.dependency 'AFNetworking', '~> 3.2.1'
#s.dependency 'Masonry', '~> 1.0.2'
#s.dependency 'YYModel', '~> 1.0.4'
#s.dependency 'SDWebImage', '~> 5.0.4'
end
