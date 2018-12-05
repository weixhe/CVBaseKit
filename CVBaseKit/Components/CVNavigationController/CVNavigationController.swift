//
//  CVNavigationController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/25.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

open class CVNavigationController: UINavigationController {

}

// MARK: - Lift Cycle
extension CVNavigationController {
    override open var shouldAutorotate: Bool {
        return true
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscapeLeft, .landscapeRight]
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    
    open override var isNavigationBarHidden: Bool {
        set {}
        get { return super.isNavigationBarHidden }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        
        
    }
}

// MARK: - Life Cycle
extension CVNavigationController {
    open override func viewWillLayoutSubviews() {
        
        if let bar = visibleViewController?.cv_navigationBar {
            
            if UIDevice.current.userInterfaceIdiom == .phone {  // iPhone
                
                switch UIApplication.shared.statusBarOrientation {
                case .landscapeLeft, .landscapeRight:   // 横屏
                    bar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: navigationBar.frame.width, height: navigationBar.frame.height))
                default:    // 竖屏
                    bar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: navigationBar.frame.width, height: navigationBar.frame.height + UIApplication.shared.statusBarFrame.height))
                    
                }
                
            } else if UIDevice.current.userInterfaceIdiom == .pad { // ipad
                bar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: navigationBar.frame.width, height: navigationBar.frame.height + UIApplication.shared.statusBarFrame.height))
            }
        }
        
    }
    
    /// push 动作
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        if viewController.cv_navigationBar == nil  {
            let bar = _cv_navgationBar()
            let item = _cv_navgationItem(bind: bar)
            viewController.cv_navigationItem = item
            viewController.cv_navigationBar = bar
        }
        
        super.pushViewController(viewController, animated: true)
        if viewControllers.count > 1 {

            if let item = viewController.cv_navigationItem, item.leftItem == nil, item.leftItems == nil {

                var image: UIImage?
                if let bundlePath = Bundle.main.path(forResource: "CVNavigation", ofType: "bundle") {
                    
                    let suffix = UIScreen.main.scale == 2 ? "@2x" : UIScreen.main.scale == 3 ? "@3x" : "@1x"
                    
                    if let imagePath = Bundle(path: bundlePath)?.path(forResource: "default_back\(suffix)", ofType: "png") {
                        image = UIImage(contentsOfFile: imagePath)
                    }
                }
                
                item.backButtonItem = CVBarButtonItem(title: "返回", image: image, target: viewController, action: #selector(UIViewController.backToPrevious))
            }
        }
        viewWillLayoutSubviews()
    }
    
    open override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        viewWillLayoutSubviews()
    }
}

// MARK: - Public Methods
extension CVNavigationController {
    
}

// MARK: - Private Methods
fileprivate extension CVNavigationController {
    
}

// MARK: - Getter Setter
fileprivate extension CVNavigationController {
    func _cv_navgationBar() -> CVNavigationBar {
        let nb = CVNavigationBar(frame: CGRect.zero)
        nb.backgroundColor = UIColor.white
        return nb
    }
    
    func _cv_navgationItem(bind navigationBar: CVNavigationBar?) -> CVNavigationItem {
        let ni = CVNavigationItem()
        ni.bind(to: navigationBar)
        return ni
    }
}
