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

        
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 60))
        label.text = "首页"
        label.textAlignment = .center
        view.addSubview(label)
     
        
        let button = UIButton(type: .custom)
        button.setTitle("Push", for: .normal)
        button.frame = CGRect(x: 10, y: 100, width: 60, height: 40)
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(onClickButtonAction), for: .touchUpInside)
        view.addSubview(button)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func onClickButtonAction() {
        self.navigationController?.pushViewController(Home_2ViewController(), animated: true)
    }

}
