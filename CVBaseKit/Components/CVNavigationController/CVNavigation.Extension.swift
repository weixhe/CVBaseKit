//
//  CVNavigation.Extension.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/25.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    private struct ExtensionKey {
        static var navigationItem: String = "com.cv.navigationItem"
    }
    
    public var cv_navigationItemItem: CVNavigationItem? {
        get {
            return objc_getAssociatedObject(self, &ExtensionKey.navigationItem) as? CVNavigationItem
        }
        set {
            objc_setAssociatedObject(self, &ExtensionKey.navigationItem, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
