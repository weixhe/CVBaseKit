//
//  HomeSearchViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/12/5.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

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
