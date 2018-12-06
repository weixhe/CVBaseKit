//
//  CVNavigationItem.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/25.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

private typealias __NavigationContainerView = UIView

private let DefaultBarHeight: CGFloat = 44

open class CVNavigationItem: NSObject {

    public private(set) var backButtonItem: CVBarButtonItem? { didSet { _backButtonItemDidSet() } }
    public var backButtonItemHidden: Bool = false { didSet { _backButtonItemHiddenDidSet() } }
    
    public var leftItem: CVBarButtonItem? { willSet { _leftItemWillSet() } didSet { _leftItemDidSet() } }
    public var rightItem: CVBarButtonItem? { willSet { _rightItemWillSet() } didSet { _rightItemDidSet() } }
    
    public var font: UIFont? { didSet { _fontDidSet() } }
    public var textColor: UIColor? { didSet { _textColorDidSet() } }
    public var title: String? { didSet { _titleDidSet() } }
    
    public var titleView: UIView? { willSet { _titleViewWillSet() } didSet { _titleViewDidSet() } }
    public var leftItems: [CVBarItem]? { willSet { _leftItemsWillSet() } didSet { _leftItemsDidSet() } }
    public var rightItems: [CVBarItem]? { willSet { _rightItemsWillSet() } didSet { _rightItemsDidSet() } }

    lazy private var titleLabel: UILabel = { return _titleLabel() }()
    lazy private var contentView: __NavigationContainerView = { return _contentView() }()
    weak private var viewController: UIViewController?
    private let appearance = CVNavigationAppearance.share
    deinit {
        removeNotify()
    }
}

// MARK: - Public - Notification
extension CVNavigationItem {
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UIView, obj == contentView.superview! {
            if let key = keyPath, key == "frame" {
                if let frame = change?[NSKeyValueChangeKey.newKey] as? CGRect {
                    contentView.frame = frame
                    updateFrame()
                }
            }
        } else if let _ = object as? UIViewController {
            if let key = keyPath, key == "title" {
                if let text = change?[NSKeyValueChangeKey.newKey] as? String {
                    title = text
                }
            }
        }
    }
}

// MARK: - Public - Other Methods
extension CVNavigationItem {
    public func bind(to navigatonBar: CVNavigationBar?) {
        if let bar = navigatonBar {
            bar.addSubview(contentView)
            contentView.frame = bar.bounds
            addNotify()
        }
    }
    
    public func bind(to controller: UIViewController?) {
        if let controller = controller {
            viewController = controller
            addNotify()
        }
    }
}

// MARK: - Private - Other Methods
fileprivate extension CVNavigationItem {
    func addNotify() {
        contentView.superview?.addObserver(self, forKeyPath: "frame", options: [.new], context: nil)
        viewController?.addObserver(self, forKeyPath: "title", options: [.new], context: nil)
    }
    
    func removeNotify() {
        contentView.superview?.removeObserver(self, forKeyPath: "frame")
        viewController?.removeObserver(self, forKeyPath: "title")

    }
    
    func updateFrame() {
        
        guard contentView.frame.width != 0 else { return }
        
        var safe_l: CGFloat = 0
        var safe_r: CGFloat = 0
        if let view = UIApplication.shared.keyWindow {
            if #available(iOS 11.0, *) {
                safe_l = view.safeAreaInsets.left
                safe_r = view.safeAreaInsets.right
            }
        }
        
        if let item = backButtonItem {
            item.center = CGPoint(x: safe_l + item.frame.size.width / 2, y: contentView.frame.height - DefaultBarHeight / 2)
        }
        
        // 优先考虑数组，然后考虑单个
        if let items = leftItems {
            backButtonItem?.isHidden = true // 如果有left，则back直接隐藏
            leftItem?.removeFromSuperview()
            var move_x: CGFloat = safe_l        // 每一个item的起始点
            for one in items {
                if one.isKind(of: CVBarButtonItem.self) {
                    one.center = CGPoint(x: move_x + one.frame.size.width / 2, y: contentView.frame.height - DefaultBarHeight / 2)
                    move_x = one.frame.maxX
                } else if one.isKind(of: CVBarSpaceItem.self) {
                    move_x += (one as! CVBarSpaceItem).space
                }
            }
        } else if let item = leftItem {
            backButtonItem?.isHidden = true // 如果有left，则back直接隐藏
            item.center = CGPoint(x: safe_l + item.frame.size.width / 2, y: contentView.frame.height - DefaultBarHeight / 2)
        }
        
        // 优先考虑数组，然后考虑单个
        if let items = rightItems {
            rightItem?.removeFromSuperview()
            var move_x: CGFloat = safe_r        // 每一个item的起始点
            let center_y = contentView.frame.height - DefaultBarHeight / 2
            for one in items {
                if one.isKind(of: CVBarButtonItem.self) {
                    let center_x = contentView.frame.width - (move_x + one.frame.size.width / 2)
                    one.center = CGPoint(x: center_x, y: center_y)
                    move_x += one.frame.size.width
                } else if one.isKind(of: CVBarSpaceItem.self) {
                    move_x += (one as! CVBarSpaceItem).space
                }
            }
        } else if let item = rightItem {
            let center_x = contentView.frame.width - (safe_r + item.frame.size.width / 2)
            let center_y = contentView.frame.height - DefaultBarHeight / 2
            item.center = CGPoint(x: center_x, y: center_y)
        }
        
        if let view = titleView {
            titleLabel.removeFromSuperview()  // 如果有titleView, 就把title去掉
            view.center = CGPoint(x: contentView.frame.width / 2, y: contentView.frame.height - DefaultBarHeight / 2)
        } else {
            if let _ = title {
                titleLabel.center = CGPoint(x: contentView.frame.width / 2, y: contentView.frame.height - DefaultBarHeight / 2)
            }
        }
        
    }
}

// MARK: - Private - Getter
fileprivate extension CVNavigationItem {
    
    func _titleLabel() -> UILabel {
        let lb = UILabel(frame: CGRect.zero)
        lb.textColor = textColor ?? appearance.titleColor
        lb.numberOfLines = 0
        lb.lineBreakMode = .byTruncatingMiddle
        lb.font = font ?? appearance.titleFont
        return lb
    }
    
    func _contentView() -> __NavigationContainerView {
        let cv = __NavigationContainerView()
        cv.backgroundColor = UIColor.clear
        return cv
    }
}

// MARK: - Private - Will Set
private extension CVNavigationItem {
    func _leftItemWillSet() {
        leftItem?.removeFromSuperview()
    }
    
    func _rightItemWillSet() {
        rightItem?.removeFromSuperview()
    }
    
    func _titleViewWillSet() {
        titleView?.removeFromSuperview()
    }
    
    func _leftItemsWillSet() {
        if let items = leftItems {
            for one in items {
                if one.isKind(of: CVBarButtonItem.self) {
                    contentView.removeFromSuperview()
                }
            }
        }
    }
    
    func _rightItemsWillSet() {
        if let items = rightItems {
            for one in items {
                if one.isKind(of: CVBarButtonItem.self) {
                    contentView.removeFromSuperview()
                }
            }
        }
    }

}

// MARK: - Private - Did Set
private extension CVNavigationItem {
    func _backButtonItemDidSet() {
        if let item = backButtonItem {
            contentView.addSubview(item)
            item.font = UIFont.systemFont(ofSize: 16)
            item.textColor = UIColor(red: 56 / 255.0, green: 129 / 255.0, blue: 242 / 255.0, alpha: 1)
            updateFrame()
        }
    }
    
    func _backButtonItemHiddenDidSet() {
        if backButtonItemHidden {
            backButtonItem?.isHidden = true
            
        } else {
            
            if let item = backButtonItem {
                item.isHidden = false
            } else {
                
                var image: UIImage?
                if let bundlePath = Bundle.main.path(forResource: "CVNavigation", ofType: "bundle") {
                    
                    let suffix = UIScreen.main.scale == 2 ? "@2x" : UIScreen.main.scale == 3 ? "@3x" : "@1x"
                    
                    if let imagePath = Bundle(path: bundlePath)?.path(forResource: "default_back\(suffix)", ofType: "png") {
                        image = UIImage(contentsOfFile: imagePath)
                    }
                }
                
                backButtonItem = CVBarButtonItem(title: "返回", image: image, target: viewController, action: #selector(UIViewController.backToPrevious))
            }
            
        }
    }
    
    func _leftItemDidSet() {
        if let item = leftItem {
            backButtonItemHidden = true
            contentView.addSubview(item)
            updateFrame()
        }
    }
    
    func _rightItemDidSet() {
        if let item = rightItem {
            contentView.addSubview(item)
            updateFrame()
        }
    }
    
    func _fontDidSet() {
        titleLabel.font = font ?? appearance.titleFont
        titleLabel.sizeToFit()
        updateFrame()
    }
    
    func _textColorDidSet() {
        titleLabel.textColor = textColor ?? appearance.titleColor
    }
    
    func _titleDidSet() {
        titleLabel.text = title
        title != nil ? contentView.addSubview(titleLabel) : titleLabel.removeFromSuperview()
        titleLabel.sizeToFit()
        updateFrame()
    }
    
    func _titleViewDidSet() {
        if titleView != nil {
            contentView.addSubview(titleView!)
            updateFrame()
        }
    }
    
    func _leftItemsDidSet() {
        if let items = leftItems {
            backButtonItemHidden = true
            for one in items {
                if one.isKind(of: CVBarButtonItem.self) {
                    contentView.addSubview(one)
                }
            }
            updateFrame()
        }
    }
    
    func _rightItemsDidSet() {
        if let items = rightItems {
            for one in items {
                if one.isKind(of: CVBarButtonItem.self) {
                    contentView.addSubview(one)
                }
            }
            updateFrame()
        }
    }
}
