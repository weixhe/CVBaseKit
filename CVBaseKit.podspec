Pod::Spec.new do |s|
  s.name         = "CVBaseKit"    #存储库名称
  s.version      = "1.1.9"      #版本号，与tag值一致
  s.summary      = "CVBaseKit"  #简介
  s.swift_version= "4.2"
  s.description  = "This is a Kit Project for swift."  #描述
  s.homepage     = "https://github.com/weixhe/CVBaseKit"      #项目主页，不是git地址
  s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
  s.author       = { "weixhe" => "workerwei@163.com" }  #作者
  s.platform     = :ios, "8.0"                  #支持的平台和版本号
  s.source       = { :git => "https://github.com/weixhe/CVBaseKit.git", :tag => "1.1.9" }         #存储库的git地址，以及tag值
  # s.source_files =  "Classes/**/*.{swift, plist}" #需要托管的源代码路径
  s.requires_arc = true #是否支持ARC

  #  组件Global
  s.subspec 'Global' do |ss|
  	ss.source_files = "CVBaseKit/Global/CVConst.swift"     # 需要托管的源代码路径	
  end

  #  组件Device
  s.subspec 'CVDevice' do |ss|
  	ss.source_files = "CVBaseKit/CVDevice/*.{swift, plist}"    # 需要托管的源代码路径
  	ss.dependency "KeychainAccess"    #所依赖的第三方库，没有就不用写
  	ss.framework = "SystemConfiguration"
  end

  # 组件CVTabBarController
  s.subspec 'Components' do |ss|
    ss.subspec 'CVTabBarController' do |sss|
      sss.source_files = "CVBaseKit/Components/CVTabBarController/*.{swift}"   # 需要托管的源代码路径
    end
    ss.subspec 'CVNavigationController' do |sss|
      sss.source_files = "CVBaseKit/Components/CVNavigationController/*.{swift}"   # 需要托管的源代码路径
    end
  end

  # s.dependency "KeychainAccess"    #所依赖的第三方库，没有就不用写

end
