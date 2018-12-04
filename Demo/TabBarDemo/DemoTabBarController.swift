//
//  DemoTabBarController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/24.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit


class DemoTabBarController: CVTabBarController {

    
    var n: Int = 0
    
}

extension DemoTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        homeVC.cv_tabBarItem = CVTabBarItem(image: UIImageName("Tabbar_Home_N"), selectedImage: UIImageName("Tabbar_Home_H"), title: "首页", selectedTitle: "首页")
        let nav_Home = CVNavDemoViewController(rootViewController: homeVC)
        
        let recommendVC = RecommendViewController()
        recommendVC.cv_tabBarItem = CVTabBarItem(image: UIImageName("Tabbar_Recommend_N"), selectedImage: UIImageName("Tabbar_Recommend_H"), title: "收藏", selectedTitle: "收藏")

        let nav_Recommend = CVNavDemoViewController(rootViewController: recommendVC)
        
        let testVC = TestViewController()
        testVC.cv_tabBarItem = CVTabBarItem(image: UIImageName("Tabbar_Test_N"), selectedImage: UIImageName("Tabbar_Test_H"), title: "测试", selectedTitle: "测试")
        let nav_Test = CVNavDemoViewController(rootViewController: testVC)
        
        let shoppingCartVC = ShoppingCartViewController()
        shoppingCartVC.cv_tabBarItem = CVTabBarItem(image: UIImageName("Tabbar_ShopCart_N"), selectedImage: UIImageName("Tabbar_ShopCart_H"), title: "购物车", selectedTitle: "购物车")
        let nav_ShoppingCart = CVNavDemoViewController(rootViewController: shoppingCartVC)
        
        let smallVideoVC = SmallVideoViewController()
        smallVideoVC.cv_tabBarItem = CVTabBarItem(image: UIImageName("Tabbar_Order_N"), selectedImage: UIImageName("Tabbar_Order_H"), title: "小视频", selectedTitle: "小视频")
        let nav_SmallVideo = CVNavDemoViewController(rootViewController: smallVideoVC)
        
        let friendsVC = FriendsViewController()
        friendsVC.cv_tabBarItem = CVTabBarItem(image: UIImageName("Tabbar_Mine_N"), selectedImage: UIImageName("Tabbar_Mine_H"), title: "朋友", selectedTitle: "朋友")
        let nav_Friends = CVNavDemoViewController(rootViewController: friendsVC)
        
        self.viewControllers = [nav_Home, nav_Recommend, nav_Test, nav_ShoppingCart, nav_SmallVideo, nav_Friends]
        self.showItems = [0, 1, 2, 3]
        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 49, height: 49))
//        view.backgroundColor = UIColor.red
//
//        let cycle = UIView(frame: CGRect(x: 0, y: -20, width: 49, height: 49))
//        cycle.layer.cornerRadius = 49 / 2
//        cycle.layer.masksToBounds = true
//        cycle.backgroundColor = UIColor.red
//        view.addSubview(cycle)
//
//        self.insert(view: view, at: 0)
        
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerRunning(timer:)), userInfo: nil, repeats: false)
        onTimerRunning(timer: nil)
        
    }
    
    @objc func onTimerRunning(timer: Timer?) {
        n += 8
        if n > 110 {
            timer?.invalidate()
        }
        if n < 100 {
            self.updatePaopao(text: "\(n)", at: 0)
        } else {
            self.updatePaopao(text: "99+", at: 0)
        }
        
//        if n < 50 {
//            self.updatePaopao(text: nil, offset: CGSize(width: 15, height: -15), at: 1, isHidden: false)
//        } else {
//            self.updatePaopao(text: nil, offset: CGSize(width: 15, height: -15), at: 1, isHidden: true)
//        }
        
        if n == 32 {

//            self.changeToIndex(3)
        }
    }
}
