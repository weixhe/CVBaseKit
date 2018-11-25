//
//  CVConst.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/18.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import Foundation
import UIKit


/**
 *   定义DUBUG宏 TARGETS --> Build Settings --> Swift Complier - Custom Flags --> Other Swift Flags --> DEBUG
 　　　　格式 -D DEBUG 。也就是声明的宏之前要加一个这样的符号 -D 。它会自动分成两行显示。
 */
public func CVLog<N>(_ message: N, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG // 若是Debug模式下，则打印
    let fileName = (file as NSString).lastPathComponent
    print("\n文件名: \(fileName)\n方法: \(method)\n行号: \(line)\n打印信息: \(message)");
    #endif
}

//let APDL = UIApplication.shared.delegate as! AppDelegate




// MARK: - 屏幕尺寸
public let SCREEN_WIDTH = UIScreen.main.bounds.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.height

public let SCREEN_WIDTH_SAFE = screen_width_safe()
public let SCREEN_HEIGHT_SAFE = screen_height_safe()

public let SafeAreaInsets = SafeAreaInsetsIn(view: UIApplication.shared.windows.first)

public let Nav_Height = Navigation_height()
public let Tab_Height = TabBar_height()


// MARK: - 安全区域
/// 返回view的安全区域
public func SafeAreaInsetsIn(view: UIView?) -> UIEdgeInsets {
    
    if #available(iOS 11.0, *) {
        if let view = view {
            return view.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    } else {
        return UIEdgeInsets.zero
    }
}

// 返回view的高度，去除安全区域
private func screen_height_safe() -> CGFloat {
    return SCREEN_HEIGHT - SafeAreaInsets.top - SafeAreaInsets.bottom
}

private func screen_width_safe() -> CGFloat {
    return SCREEN_WIDTH - SafeAreaInsets.left - SafeAreaInsets.right
}

/// 导航栏的高度：导航栏高（44）+ 状态栏高（普通的20，iPhoneX是44）
private func Navigation_height() -> CGFloat {
    let safeAreaTop: CGFloat = UIApplication.shared.statusBarFrame.size.height
    return 44.0 + safeAreaTop;
}

/// tabBar的高度：tabBar高（49）+ 下安全序区域（普通是0，iPhoneX是34）
private func TabBar_height() -> CGFloat {
    let height = 49 + SafeAreaInsets.bottom
    return height
}


// MARK: - 系统版本
/// 判断某个确定的系统版本，eg：version == 8.0
public func SysVer(_ version: Float) -> Bool {
    return (UIDevice.current.systemVersion as NSString).floatValue == version
}

/// 判断系统版本小于某版本，eg：version < 8.0
public func SysVerBelow(_ version: Float) -> Bool {
    return (UIDevice.current.systemVersion as NSString).floatValue < version
}

/// 判断系统版本大于某版本，eg：version > 8.0
public func SysVerAboard(_ version: Float) -> Bool {
    return (UIDevice.current.systemVersion as NSString).floatValue > version
}

/// 判断系统版本介于两个版本之间，eg：8.0 < version < 12.0
public func SysVerBetween(minVersion: Float, maxVersion: Float) -> Bool {
    return (UIDevice.current.systemVersion as NSString).floatValue > minVersion && (UIDevice.current.systemVersion as NSString).floatValue < minVersion
}


// MARK: - 屏幕适配
/// 根据设计图，进行尺寸变换, 默认：375
public func Factor(reference: CGFloat = 375, x: CGFloat) -> CGFloat {
    return SCREEN_WIDTH / reference * x
}


/** 这个参数,看公司项目UI图 具体是哪款机型,默认  iphone6
 RealUISrceenWidth  (4/4s/5/5s)-320.0  (6/6s/7/7s/8/8s)-375.0  (6p/6sp/7p/7ps/8p/8ps/XR/XS MAX)-414.0 (X/XS)-375 ()-414
 RealUISrceenHeight (4/4s)-480 (5/5s)-568.0  (6/6s/7/7s/8/8s)-667.0 (6p/6sp/7p/7ps/8p/8ps)-736.0  (x)-812 (XR/XS MAX)-896 (XS)-812
 */


// MARK: - UIImage
public func UIImageName(_ imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? UIImage()
}



// MARK: - 设备信息，版本号
/// 系统版本号
public let SysVersion = UIDevice.current.systemVersion
/// 系统名称("iOS", "tvOS", "watchOS", "macOS")
public let SysName = UIDevice.current.systemName

/// 程序名称
public let AppName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String ?? ""
/// 主程序版本号
public let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
/// build版本
public let AppBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String






// MARK: - 目录路径
// Documents目录路径
public let DocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
public let LibraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
// Library/Caches目录路径方法
public let CachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
// Library/Application Support目录路径
public let ApplicationSupportPath = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0]
// tmp目录路径
public let TmpPath = NSTemporaryDirectory()
// 沙盒主目录路径
public let HomePath = NSHomeDirectory()



// MARK: - 取随机数
public func Arc4random(min: UInt32 = 0, max: UInt32) -> UInt32 {
    guard max > min else { return 0 }
    return Darwin.arc4random() % max + min
}




// MARK: - 电话呼叫
/// - phone: 被叫方的电话号码
/// - immediately: 是否跳过确认提示 默认需要确认
/// - Return: 不支持电话功能时返回 false
@discardableResult
public func AppCall(_ phone: String, immediately: Bool = false) -> Bool {
    let typeString = immediately ? "tel" : "telprompt"
    if let callURL = URL(string: typeString + "://" + phone), UIApplication.shared.canOpenURL(callURL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(callURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(callURL)
        }
        return true
    }
    return false
}
