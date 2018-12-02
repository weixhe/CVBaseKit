//
//  CVNavigationAppearance.swift
//  CVBaseKit
//
//  Created by caven on 2018/12/2.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

/// navBar 设置样式，必须在navBarh出现之前设置，否则无用
public class CVNavigationAppearance: NSObject {
    static let share = CVNavigationAppearance()
    
    // items
    public var itemFont = UIFont.systemFont(ofSize: 18)
    public var itemTextColor = UIColor.black
    
    // title
    public var titleFont = UIFont.systemFont(ofSize: 18)
    public var titleColor = UIColor.black
    
}
