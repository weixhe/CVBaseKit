//
//  CVSearchViewController.swift
//  CVBaseKit
//
//  Created by caven on 2018/12/5.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

private let DefaultBarHeight: CGFloat = 44      // navBar 的高度是44
private let DefaultSearchTFHeight: CGFloat = 30 // 搜索框的高度
private let Margin: CGFloat = 10        // 两侧的间距
private let DefaultCancelColor = UIColor(red: 56 / 255.0, green: 129 / 255.0, blue: 242 / 255.0, alpha: 1)

/// 搜索控制器，本控制器是根据CVNavBarController生产的

open class CVSearchViewController: UIViewController {
    
    public var leftView: UIView? { didSet { _leftViewDidSet() } }
    public var rightView: UIView? { didSet { _rightViewDidSet() } }
    public var showCancel: Bool = false { didSet { _showCancelDidSet() } }

    lazy public var searchTF: UITextField = { return _searchTF() }()
    lazy public var tableView: UITableView = { return _tableView() }()
    lazy public var resultTableView: UITableView = { return _resultTableView() }()
    
    lazy private var cancelBtn: UIButton = { return _cancelBtn() }()
    lazy private var maskView: UIView = { return _maskView() }()

}

// MARK: - Life Cycle
extension CVSearchViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        cv_navigationItem?.backButtonItemHidden = true
    }
    
    open override func viewWillLayoutSubviews() {
        
        updateSearchTFFrame()
    }
}

// MARK: - Public - UITextFieldDelegate
extension CVSearchViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        maskView.isHidden = false
        assert_bar()
        maskView.frame = CGRect(x: 0, y: cv_navigationBar!.frame.maxY, width: view.frame.width, height: view.frame.height - cv_navigationBar!.frame.height)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        maskView.isHidden = true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Private - Actions
private extension CVSearchViewController {
    @objc func onClickCancelAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private - Other Methods
private extension CVSearchViewController {
    
    /// 更新搜索框的高度
    func updateSearchTFFrame() {
        
        var LRWidth: CGFloat = 0    // 左侧view + 右侧view + 两侧的margin， 剩下的就是searchTF 的宽度
        
        if let lv = leftView { LRWidth += lv.frame.width}
        if let rv = rightView { LRWidth += rv.frame.width }
        if showCancel { LRWidth += cancelBtn.frame.width }
        LRWidth += Margin * 2
        
        searchTF.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.cv_navigationBar!.frame.width - LRWidth, height: DefaultSearchTFHeight))
        
        let centerX = searchTF.frame.width / 2 + (leftView != nil ? leftView!.frame.width : 0) + Margin
        searchTF.center = CGPoint(x: centerX,
                                  y: self.cv_navigationBar!.frame.height - DefaultBarHeight / 2)
        
    }
    
    func assert_bar() {
        assert(self.cv_navigationBar != nil, "使用本控制器必须使用<CVNavBarController>")
    }
    
}

// MARK: - Private - Getter
private extension CVSearchViewController {
    
    func _searchTF() -> UITextField {
        let tf = UITextField(frame: CGRect.zero)
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        tf.delegate = self
        tf.returnKeyType = .done
        cv_navigationBar?.addSubview(tf)
        return tf
    }
    
    func _tableView() -> UITableView {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        view.addSubview(tb)
        return tb
    }
    
    func _resultTableView() -> UITableView {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.isHidden = true
        view.addSubview(tb)
        return tb
    }
    
    func _cancelBtn() -> UIButton {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(DefaultCancelColor, for: .normal)
        cancelBtn.addTarget(self, action: #selector(onClickCancelAction(sender:)), for: .touchUpInside)
        cancelBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        return cancelBtn
    }
    
    func _maskView() -> UIView {
        let v = UIView(frame: CGRect.zero)
        v.backgroundColor = UIColor.init(white: 0, alpha: 0.45)
        v.isHidden = true
        view.addSubview(v)
        return v
    }
}

// MAKR: - Private - Did Set
private extension CVSearchViewController {
    func _leftViewDidSet() {
        if let lv = leftView {
            assert_bar()
            self.cv_navigationBar!.addSubview(lv)
            lv.center = CGPoint(x: lv.frame.width / 2,
                                y: self.cv_navigationBar!.frame.height - DefaultBarHeight / 2)
        }
        updateSearchTFFrame()
    }
    
    func _rightViewDidSet() {
        if let rv = rightView {
            assert_bar()
            self.cv_navigationBar!.addSubview(rv)
            
            if showCancel {
                rv.center = CGPoint(x: cancelBtn.frame.minX - rv.frame.width / 2,
                                    y: self.cv_navigationBar!.frame.height - DefaultBarHeight / 2)
            } else {
                rv.center = CGPoint(x: self.cv_navigationBar!.frame.width - rv.frame.width / 2,
                                    y: self.cv_navigationBar!.frame.height - DefaultBarHeight / 2)
            }
        }
        updateSearchTFFrame()
    }
    
    func _showCancelDidSet() {
        if showCancel {
            assert_bar()
            self.cv_navigationBar!.addSubview(cancelBtn)
            cancelBtn.isHidden = false
            cancelBtn.center = CGPoint(x: self.cv_navigationBar!.frame.width - cancelBtn.frame.width / 2,
                                       y: self.cv_navigationBar!.frame.height - DefaultBarHeight / 2)
        } else {
            cancelBtn.isHidden = true
            cancelBtn.removeFromSuperview()
        }
        updateSearchTFFrame()
    }
}
