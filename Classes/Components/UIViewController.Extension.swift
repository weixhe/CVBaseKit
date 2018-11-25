//
//  UIViewController.Extension.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/24.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    private struct ExtensionKey {
        static var tabBarItem: String = "com.cv.tabBarItem"
    }
    
    public var cv_tabBarItem: CVTabBarItem? {
        get {
            return objc_getAssociatedObject(self, &ExtensionKey.tabBarItem) as? CVTabBarItem
        }
        set {
            objc_setAssociatedObject(self, &ExtensionKey.tabBarItem, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
