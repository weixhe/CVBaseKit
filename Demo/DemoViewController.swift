//
//  DemoViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/18.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    var demo: DemoConverable?
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: Nav_Height, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - Nav_Height))
        label.numberOfLines = 0
        label.backgroundColor = UIColor.lightGray
        return label
    }()
}
// MARK: - Lift Cycle
extension DemoViewController {
    
    convenience init(demo: DemoConverable) {
        self.init()
        self.demo = demo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(label)
        label.text = self.demo?.text
    }
}
