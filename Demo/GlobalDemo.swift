//
//  GlobalDemo.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/18.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class GlobalDemo: NSObject, DemoConverable {
    var text: String {
        
        
        
        return  """
                屏幕尺寸："(\(SCREEN_WIDTH), \(SCREEN_HEIGHT))"
                屏幕安全尺寸："(\(SCREEN_WIDTH_SAFE), \(SCREEN_HEIGHT_SAFE))"
                屏幕安全区域："(\(SafeAreaInsets.top), \(SafeAreaInsets.left),\(SafeAreaInsets.bottom),\(SafeAreaInsets.right))"
                Nav Tab 高度：(\(Nav_Height), \(Tab_Height))
                系统版本：\(SysVersion)
                系统名字：\(SysName)
                App名字：\(AppName)
                主程序版本号：\(AppVersion)
                build版本：\(AppBuildVersion)
                系统版本判断：\(SysVer(12.1))
                """
    }
}
