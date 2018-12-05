//
//  Home_2ViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/28.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

class Home_2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 显示单个
//        cv_navigationItem?.leftItem = CVBarButtonItem(title: "<-", image: nil, target: self, action: #selector(back))
        cv_navigationItem?.rightItem = CVBarButtonItem(title: "share", target: self, action: #selector(share))
        
        // 显示多个
        let space1 = CVBarSpaceItem(space: 10)
        let space2 = CVBarSpaceItem(space: -10)
//
//        let item1 = CVBarButtonItem(title: "关闭", target: nil, action: nil)
//        let item2 = CVBarButtonItem(title: "刷新", target: nil, action: nil)
//        cv_navigationItem?.leftItems = [space1, item1, space2, item2]
        
        
        let item3 = CVBarButtonItem(title: "关闭", target: self, action: #selector(share))
        item3.textColor = UIColor.red
        item3.font = UIFont.systemFont(ofSize: 26)
        let item4 = CVBarButtonItem(title: "刷新", target: nil, action: nil)
        cv_navigationItem?.rightItems = [space1, item3, space2, item4]
        
        // 显示title
        self.title = "首页-2"
//  或   cv_navigationItem?.title = "首页-2"
        
        // 设置titleView
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        titleView.backgroundColor = UIColor.red
        cv_navigationItem?.titleView = titleView
    }
    

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func share() {
        CVLog("share to friend")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
