//
//  CVBarSpaceItem.swift
//  CVBaseKit
//
//  Created by caven on 2018/12/2.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

public class CVBarSpaceItem: CVBarItem {
    public var space: CGFloat = 0
}

// MARK: - Life Cycle
extension CVBarSpaceItem {
    convenience init(space: CGFloat) {
        self.init()
        self.space = space
    }
}
