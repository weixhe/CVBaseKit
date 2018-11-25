Pod::Spec.new do |s|
  s.name         = "CVBaseKit"    #存储库名称
  s.version      = "1.1.0"      #版本号，与tag值一致
  s.summary      = "Device"  #简介
  s.swift_version= "4.2"
  s.description  = "This is a Kit Project for swoft."  #描述
  s.homepage     = "https://github.com/weixhe/CVBaseKit"      #项目主页，不是git地址
  s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
  s.author             = { "weixhe" => "workerwei@163.com" }  #作者
  s.platform     = :ios, "8.0"                  #支持的平台和版本号
  s.source       = { :git => "https://github.com/weixhe/CVBaseKit.git", :tag => "1.1.0" }         #存储库的git地址，以及tag值
  # s.source_files =  "CVBaseKit/**/*.{swift, plist}" #需要托管的源代码路径
  s.requires_arc = true #是否支持ARC

  #  组件Global
  s.subspec 'Global' do |gs|
  	gs.source_files = "Classes/Global/CVConst.swift"     # 需要托管的源代码路径	
  end

  #  组件Device
  s.subspec 'CVDevice' do |ds|
  	ds.source_files = "Classes/CVDevice/*.{swift, plist}"    # 需要托管的源代码路径
  	ds.dependency "KeychainAccess"    #所依赖的第三方库，没有就不用写
  	ds.framework = "SystemConfiguration"
  end

  # 组件CVTabBarController
  s.subspec 'CVTabBarController' do |ts|
    ds.source_files = "Classes/Components/CVTabBarController/*.{swift}"   # 需要托管的源代码路径
  end

  # s.dependency "KeychainAccess"    #所依赖的第三方库，没有就不用写

end
