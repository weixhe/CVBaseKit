//
//  CVNavDemoViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/25.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class CVNavDemoViewController: CVNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count == 1 {
            viewController.hidesBottomBarWhenPushed = true //viewController是将要被push的控制器
        }
        super.pushViewController(viewController, animated: true)
    }

}
