//
//  HomeViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/24.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.red
        
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 60))
        label.text = "首页"
        label.textAlignment = .center
        view.addSubview(label)
        
    }

}
