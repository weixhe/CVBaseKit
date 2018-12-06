# CVBaseKit

总结一些基础的框架，例如nav，tab等，持续更新中......

### 引入工程
```
pod 'CVBaseKit'   // 引入所有的框架
pod 'CVBaseKit/CVDevice'    // 引入CVDevice
pod 'CVBaseKit/Global/CVConst'    // 引入全局方法，声明，类似OC中的一些全局宏定义
pod 'CVBaseKit/Components'        // 引入所有组件
pod 'CVBaseKit/Components/CVTabBarController'     // 引入组件 - tabBar
pod 'CVBaseKit/Components/CVNavigationController'     // 引入组件 - navBar
pod 'CVBaseKit/Components/CVSearchViewController'     // 引入组件 - nav-search
```
### 使用方法
#### 1、CVDevice的使用方法
  其中唯一标识用到了钥匙串，所以关联了 `KeychainAccess` 库
  ```
  设备型号：\(CVDevice.getDeviceModel())
  设备名称：\(CVDevice.getDeviceName())
  IP地址：\(CVDevice.getIPAddresses())
  WIFI名：\(CVDevice.getWifiName())
  MAC地址：\(CVDevice.getWifiMacAddress())
  系统版本号：\(CVDevice.sysVersion)
  系统名称：\(CVDevice.sysName)
  唯一标识：\(CVDevice.getUUID())
  ```
  再次 `CVBantterManager` 类可以监听电池的充电状态和电量变化

#### 2、CVConst使用方法
  本类中总结了打印方法 `CVLog(<#T##message: N##N#>)`
  屏幕尺寸 `SCREEN_WIDTH`, `SCREEN_HEIGHT`
  安全区域  `SCREEN_WIDTH_SAFE`, `SCREEN_HEIGHT_SAFE`, `SafeAreaInsets`
  ```
  /// 返回view的安全区域
  public func SafeAreaInsetsIn(view: UIView?) -> UIEdgeInsets
  ```
  nav 和 tab 的高度 `Nav_Height`, `Tab_Height`
  
  系统版本判断，比较
  ```
  /// 判断某个确定的系统版本，eg：version == 8.0
  func SysVer(_ version: Float) -> Bool
  /// 判断系统版本小于某版本，eg：version < 8.0
  public func SysVerBelow(_ version: Float) -> Bool
  /// 判断系统版本大于某版本，eg：version > 8.0
  public func SysVerAboard(_ version: Float) -> Bool
  /// 判断系统版本介于两个版本之间，eg：8.0 < version < 12.0
  public func SysVerBetween(minVersion: Float, maxVersion: Float) -> Bool
  ```
  
  屏幕适配
  ```
  /// 根据设计图，进行尺寸变换, 默认：375
  public func Factor(reference: CGFloat = 375, x: CGFloat) -> CGFloat 
  ```
  
  UIImage创建
  ```
  public func UIImageName(_ imageName: String) -> UIImage
  ```
  
  App信息 `AppName`, `AppVersion`, `AppBuildVersion`
  
  文件目录
  ```
  DocumentPath
  LibraryPath
  CachesPath
  ApplicationSupportPath
  TmpPath
  HomePath
  ```
  取随机数
  ```
  public func Arc4random(min: UInt32 = 0, max: UInt32) -> UInt32
  ```
  电话呼叫 返回false时不支持打电话
  ```
  public func AppCall(_ phone: String, immediately: Bool = false) -> Bool
  ```

#### 3. CVTabBarController使用方法
  
  tabBar使用相当简单，引入组件到项目中后，可集成自本类，设定好需要显示到tabBar上的控制器，然后调用设置数据源和需要显示出来的控制器的index即可
  ```
  // 设置数据源，此时数据源个数不一定为最终显示的个数和顺序
  viewControllers = [nav_Home, nav_Recommend, nav_Test, nav_ShoppingCart, nav_SmallVideo, nav_Friends]
  // 哈哈，这里的方法才是控制tabBar上需要显示的控制器和顺序，可以根据项目需求随时调整
  showItems = [0, 1, 2, 3]
  ```
  辅助方法：
  1. 特殊的item，可以插入一个特殊的位置，效仿咸鱼
  ```
  let cycle = UIView(frame: CGRect(x: 0, y: -20, width: 49, height: 49))
        cycle.layer.cornerRadius = 49 / 2
        cycle.layer.masksToBounds = true
        cycle.backgroundColor = UIColor.red
        view.addSubview(cycle)
        
  insert(view: view, at: 2)
  ```
  2. 泡泡
  ```
  /// 更新item上的paopao数字, （中心的）偏移量，是否隐藏 ； 当text==nil时，显示圆点
  func updatePaopao(text: String?, offset: CGSize = CGSize(width: 15, height: -10), at index: Int, isHidden: Bool = false)
  ```
  3. 在外界修改tab上的index
  ```
  func changeToIndex(_ index: Int)
  ```
  
#### 4. CVNavigationController使用方法
  在AppDelegate中设置nabBar的通用属性
  CVNavigationAppearance.share.itemTextColor = UIColor.red
  CVNavigationAppearance.share.itemFont = UIFont.systemFont(ofSize: 15)

  CVNavigationAppearance.share.titleColor = UIColor.orange
  CVNavigationAppearance.share.titleFont = UIFont.systemFont(ofSize: 20)
  
  在控制器的适当的位置，比如ViewDidLoad() 方法中直接设置相关属性
  ```
  // 显示单个
  cv_navigationItem?.leftItem = CVBarButtonItem(title: "<-", image: nil, target: self, action: #selector(back))
  cv_navigationItem?.rightItem = CVBarButtonItem(title: "share", target: self, action: #selector(share))
  ```
  ```
  // 显示多个
  let space1 = CVBarSpaceItem(space: 10)
  let space2 = CVBarSpaceItem(space: -10)

  let item1 = CVBarButtonItem(title: "关闭", target: nil, action: nil)
  let item2 = CVBarButtonItem(title: "刷新", target: nil, action: nil)
  cv_navigationItem?.leftItems = [space1, item1, space2, item2]
        
        
  let item3 = CVBarButtonItem(title: "关闭", target: self, action: #selector(share))
  item3.textColor = UIColor.red
  item3.font = UIFont.systemFont(ofSize: 26)
  let item4 = CVBarButtonItem(title: "刷新", target: nil, action: nil)
  cv_navigationItem?.rightItems = [space1, item3, space2, item4]
  ```
  ```
  // 显示title
  self.title = "首页-2"
  //  或   cv_navigationItem?.title = "首页-2"
  ```
  ```
  // 设置titleView
  let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
  titleView.backgroundColor = UIColor.red
  cv_navigationItem?.titleView = titleView
  ```
  
  #### 5. CVSearchViewController
  
  使用本类需要用到CVNavigationBar，并且用到了继承
  ```
  class HomeSearchViewController: CVSearchViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchTF.placeholder = "输入文字"
        self.showCancel = true
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftView.backgroundColor = UIColor.red
        self.leftView = leftView
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        rightView.backgroundColor = UIColor.brown
        self.rightView = rightView
    }
  }
  ```
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
