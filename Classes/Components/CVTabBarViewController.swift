//
//  CVTabBarViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/24.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

private let heightItem: CGFloat = 49


/// 自定义tabBarController，必须调用 updateLayout() 方法才能正确显示item

open class CVTabBarViewController: UITabBarController {

    open lazy var cv_tabBar: CVTabBar = { return _cv_tabbar() }()
    
    private var tabbarItems: [CVTabBarItem] = []  // tabBar上所有的item
    open var showItems: [Int] = []    // 控制在tabbar上面显示的item
    
    open override var viewControllers: [UIViewController]? { set { _setViewControllers(newValue) } get { return _viewControllers() } }
    open override var selectedIndex: Int { didSet { _selectedIndexDidSet() } }

    private var totalViewCotrollers: [UIViewController]?

    deinit {

    }
}

// MARK: - Life Cycle
extension CVTabBarViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.addSubview(cv_tabBar)
    }
}

// MARK: - Notification
extension CVTabBarViewController {
    
}

// MARK: - Public Methods
extension CVTabBarViewController {
    
    /// 更新TabBar上的item
    public func updateLayout() {
        guard tabbarItems.count > 0 else { return }
        guard totalViewCotrollers != nil else { return }
        
        for item in tabbarItems {
            item.delegate = nil
            item.removeFromSuperview()
        }
        
        // 如果没有手动控制tabbar上显示的item，则直接从头布局
        if showItems.count == 0 {
            for i in 0..<tabbarItems.count {
                showItems.append(i)
            }
        }
        
        let width = UIScreen.main.bounds.width / CGFloat(showItems.count)
        
        // 遍历showItems 数组中的index， 从 tabBarItems 中取出对应的item显示到tabbar上，以实现多个item，任意显示
        var cacheViewControllers: [UIViewController] = []
        for (index, key) in showItems.enumerated() {
            if totalViewCotrollers!.count <= key { continue }
            cacheViewControllers.append(totalViewCotrollers![key])
            
            let item = tabbarItems[key]
            item.delegate = self
            cv_tabBar.addSubview(item)
            item.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: heightItem)
            item.isSelected = index == selectedIndex ? true : false
        }
        
        self.viewControllers = cacheViewControllers
        
        
    }
    
    /// 更新item上的paopao数字, （中心的）偏移量，是否i隐藏
    func updatePaopao(text: String?, offset: CGSize = CGSize(width: 15, height: -10), at index: Int, isHidden: Bool = false) {
        guard tabbarItems.count > 0 else { return }
        guard showItems.count > 0 else { return }

        let shown = showItems[index]
        let item: CVTabBarItem = tabbarItems[shown]
        item.updatePaopao(text: text, offset: offset, isHidden: isHidden)
    }
    
    /// 在外界修改tab上的index
    func changeToIndex(_ index: Int) {
        selectedIndex = index
    }
}

// MARK: - CVTabBarItemDelegate
extension CVTabBarViewController: CVTabBarItemDelegate {
    public func tabBarItem(_ tabBarItem: CVTabBarItem, didSelected atIndex: Int) {
        
        guard tabbarItems.count > 0 else { return }
        
        selectedIndex = showItems.firstIndex(of: atIndex) ?? 0
    }
}

// MARK: - Private Methods
fileprivate extension CVTabBarViewController {
   
}

// MARK: - Getter Setter
fileprivate extension CVTabBarViewController {
    
    func _cv_tabbar() -> CVTabBar {
        let tb = CVTabBar(frame: self.tabBar.bounds)
        return tb
    }
    
    func _selectedIndexDidSet() {
        // 遍历，修改 item 选中状态
        for (index, key) in showItems.enumerated() {
            if tabbarItems.count <= key { continue }
            let item = tabbarItems[key]
            if index == selectedIndex {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
        }
    }
    
    func _setViewControllers(_ viewControllers: [UIViewController]?) {
        
        if showItems.count > 0 {
            super.viewControllers = viewControllers
        }
        
        if totalViewCotrollers == nil || totalViewCotrollers!.count == 0 {
            totalViewCotrollers = viewControllers
            
            // 遍历所有的控制器，生成对应的cv_tabBarItem
            if viewControllers != nil {
                for vc in viewControllers! {
                    if vc.isKind(of: UINavigationController.self) {
                        
                        if let controller = (vc as! UINavigationController).viewControllers.first, let item = controller.cv_tabBarItem {
                            tabbarItems.append(item)
                            item.index = tabbarItems.count - 1
                        }
                    } else if vc.isKind(of: UIViewController.self) {
                        if let item = vc.cv_tabBarItem {
                            tabbarItems.append(item)
                            item.index = tabbarItems.count - 1
                        }
                    }
                }
            }
        }
    }
    
    func _viewControllers() -> [UIViewController]? {
        return super.viewControllers
    }
}

extension UITabBar {
    
    // 为了只添加自定义的tabbar，重写父类的方法，进行过滤
    open override func addSubview(_ view: UIView) {
        if view.isKind(of: CVTabBar.self) {
            super.addSubview(view)
        }
    }
}
