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
        static var navigationBar: String = "com.cv.navigationBar"
        static var navigationItem: String = "com.cv.navigationItem"
    }
    
    
    public var cv_navigationBar: CVNavigationBar? {
        get {
            return objc_getAssociatedObject(self, &ExtensionKey.navigationBar) as? CVNavigationBar
        }
        set {
            if newValue != nil {
                view.addSubview(newValue!)
            }
            objc_setAssociatedObject(self, &ExtensionKey.navigationBar, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var cv_navigationItem: CVNavigationItem? {
        get {
            return objc_getAssociatedObject(self, &ExtensionKey.navigationItem) as? CVNavigationItem
        }
        set {
            newValue?.bind(to: self)
            objc_setAssociatedObject(self, &ExtensionKey.navigationItem, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}
