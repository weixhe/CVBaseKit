//
//  RecommendViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/24.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 60))
        label.text = "收藏"
        label.textAlignment = .center
        view.addSubview(label)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 100, width: 60, height: 44)
        button.setTitle("Click", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(onClickButtonAction), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    
    @objc func onClickButtonAction() {
        self.navigationController?.pushViewController(RecommendDetailViewController(), animated: true)
    }

}
