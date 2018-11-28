//
//  CVNavigationController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/25.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

open class CVNavigationController: UINavigationController {

    lazy public var cv_navgationBar: CVNavigationBar = { return _cv_navgationBar() }()
}

// MARK: - Lift Cycle
extension CVNavigationController {
    
    open override var isNavigationBarHidden: Bool {
        set {}
        get { return super.isNavigationBarHidden }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
        navigationBar.isHidden = true
        
        view.addSubview(cv_navgationBar)
    }
}

// MARK: - Life Cycle
extension CVNavigationController {
    open override func viewWillLayoutSubviews() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {  // iPhone
            
            switch UIApplication.shared.statusBarOrientation {
            case .landscapeLeft, .landscapeRight:   // 横屏
                cv_navgationBar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: navigationBar.frame.width, height: navigationBar.frame.height))
            default:    // 竖屏
                cv_navgationBar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: navigationBar.frame.width, height: navigationBar.frame.height + UIApplication.shared.statusBarFrame.height))

            }
            
        } else if UIDevice.current.userInterfaceIdiom == .pad { // ipad
            cv_navgationBar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: navigationBar.frame.width, height: navigationBar.frame.height + UIApplication.shared.statusBarFrame.height))
        }
    }
    
    open override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
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
}
