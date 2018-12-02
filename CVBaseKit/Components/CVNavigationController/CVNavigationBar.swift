//
//  CVNavigationBar.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/25.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

private let DefaultLineColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1)
private let DefaultShadowColor = UIColor.black
private let HeightBar: CGFloat = 44

///// Status-Bar
//open class CVStatusBar: UIView {
//
//}

/// Nav-Bar
open class CVNavigationBar: UIView {
    
    public var backgroundImage: UIImage? {  didSet { _backgroundImageDidSet() } }
    public var lineColor: UIColor? { didSet { _lineColorDidSet() } }
    public var isShowLine: Bool = true { didSet { _isShowLine() } }     // 默认显示line
    public var isShowShadow: Bool = false { didSet { _isShowShadow() } }
    public var shadowColor: UIColor? { didSet { _shadowColorDidSet() } }
    
    
    lazy private var backgroundImageView = { return _backgroundImageView() }()
    lazy private var line: UIView = { return _line() }()
 
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

// MARK: - Life Cycle
extension CVNavigationBar {
    open override func layoutSubviews() {
        let lineH = 1 / UIScreen.main.scale
        line.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
    }
}

// MARK: - Public Methods
extension CVNavigationBar {
    
}

// MARK: - Actions
extension CVNavigationBar {
    
}

// MARK: - Private Methods
fileprivate extension CVNavigationBar {
    func commonInit() {
        backgroundColor = UIColor.white
        addSubview(backgroundImageView)
        addSubview(line)
        isShowLine = true
    }
}

// MARK: - Getter Setter
fileprivate extension CVNavigationBar {
    func _backgroundImageDidSet() {
        backgroundImageView.image = backgroundImage
    }
    
    func _isShowLine() {
        if isShowLine {
            
            line.isHidden = false
            
            layer.shadowColor = nil
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
        }
    }
    
    func _lineColorDidSet() {
        _isShowLine()
    }
    
    func _isShowShadow() {
        if isShowShadow {
            
            line.isHidden = true
            
            layer.shadowColor = shadowColor != nil ? shadowColor!.cgColor : DefaultShadowColor.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowRadius = 3
            layer.shadowOpacity = 0.3
        }
    }
    
    func _shadowColorDidSet() {
        _isShowShadow()
    }
    
    func _backgroundImageView() -> UIImageView {
        let iv = UIImageView(frame: self.bounds)
        return iv
    }
    
    func _line() -> UIView {
        let vi = UIView(frame: CGRect.zero)
        vi.backgroundColor = lineColor ?? DefaultLineColor
        return vi
    }
}
