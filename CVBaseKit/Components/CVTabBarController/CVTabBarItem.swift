//
//  CVTabBarItem.swift
//  CVBaseKit
//
//  Created by caven on 2018/11/24.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit

private let DefaultTitleColor: UIColor = UIColor.black
private let DefaultSelectedTitleColor: UIColor = UIColor.blue
private let DefaultTitleFont: UIFont = UIFont.systemFont(ofSize: 11)
private let DefaultPaopaoHeight: CGFloat = 15

public protocol CVTabBarItemDelegate: class {
    func tabBarItem(_ tabBarItem: CVTabBarItem, didSelected atIndex: Int)
}

open class CVTabBarItem: UIView {

    public weak var delegate: CVTabBarItemDelegate?
    
    public var image: UIImage?
    public var title: String?
    public var titleColor: UIColor?
    public var titleFont: UIFont?
    
    public var selectedImage: UIImage?
    public var selectedTitle: String?
    public var selectedTitleColor: UIColor?
    public var selectedTitleFont: UIFont?
    
    
    public var isSelected: Bool = false { didSet { _isSelectedDidSet() } }
    public var index: Int = 0
    
    private lazy var imageView: UIImageView = { return _imageView() }()
    private lazy var titleLabel: UILabel = { return _titleLabel() }()
    private lazy var paopao: CVPaopao = { return _paopao() }()
    private lazy var button: UIButton = { return _button() }()
    
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
extension CVTabBarItem {
    open override func layoutSubviews() {
        updateLayout()
    }
}

// MARK: - Public Methods
extension CVTabBarItem {
    convenience init(image: UIImage?, selectedImage: UIImage?, title: String, selectedTitle: String) {
        self.init()
        
        setImage(image, state: .normal)
        setImage(selectedImage, state: .selected)
        
        setTitle(title, color: DefaultTitleColor, state: .normal)
        setTitle(selectedTitle, color: DefaultSelectedTitleColor, state: .selected)
        
        self.updateLayout()
    }
    
    func setImage(_ image: UIImage?, state: UIControl.State) {
        if state == .normal {
            self.image = image
        } else {
            self.selectedImage = image
        }
    }
    
    /// 设置 title，font， color
    func setTitle(_ title: String, font: UIFont = DefaultTitleFont, color: UIColor, state: UIControl.State) {
        if state == .normal {
            self.title = title
            setTitle(font: font, color: color, state: .normal)
        } else {
            self.selectedTitle = title
            setTitle(font: font, color: color, state: .selected)
        }
    }
    
    /// 设置 font， color
    func setTitle(font: UIFont = DefaultTitleFont, color: UIColor, state: UIControl.State) {
        if state == .normal {
            self.titleColor = color
            self.titleFont = font
        } else {
            self.selectedTitleColor = color
            self.selectedTitleFont = font
        }
    }
    
    func updatePaopao(text: String?, offset: CGSize = CGSize(width: 15, height: -10), isHidden: Bool = false) {
        paopao.content = text
        
        if let tx = text, tx.count > 0 {
            paopao.frame = CGRect(x: 0, y: 0, width: max(paopao.calWidth, DefaultPaopaoHeight), height: DefaultPaopaoHeight)
            paopao.center = CGPoint(x: center.x + offset.width, y: center.y + offset.height)
        } else {
            paopao.frame = CGRect(x: 0, y: 0, width: max(paopao.calWidth, DefaultPaopaoHeight / 2), height: DefaultPaopaoHeight / 2)
            paopao.center = CGPoint(x: center.x + offset.width, y: center.y + offset.height)
        }
        
        paopao.layer.cornerRadius = paopao.frame.height / 2
        paopao.layer.masksToBounds = true
        
        paopao.isHidden = isHidden
    }
}

// MARK: - Actions
fileprivate extension CVTabBarItem {
    @objc func onClickTouchAction(sender: UIButton) {
        delegate?.tabBarItem(self, didSelected: index)
    }
}

// MARK: - Private Methods
fileprivate extension CVTabBarItem {
    
    func commonInit() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(paopao)
        addSubview(button)
    }
    
    func updateLayout() {
        
        var imageH: CGFloat = 0
        if image != nil && title != nil {
            imageH = frame.height * 0.5
            imageView.frame = CGRect(x: 0, y: 5, width: frame.width, height: imageH)
            titleLabel.frame = CGRect(x: 0, y: imageH + 8, width: frame.width, height: height(for: title ?? ""))
        } else if image != nil {
            imageH = frame.height
            imageView.frame = CGRect(x: 0, y: 5, width: frame.width, height: imageH)
            titleLabel.frame = CGRect(x: 0, y: imageH + 8, width: frame.width, height: 0)
        } else {
            imageH = 0
            imageView.frame = CGRect(x: 0, y: 5, width: frame.width, height: imageH)
            titleLabel.frame = CGRect(x: 0, y: imageH, width: frame.width, height: frame.height - 10)
        }
        
        button.frame = bounds
    }
    
    /// 更新状态，会改变item上的image和title
    func updateState() {
        if !isSelected {
            imageView.image = image
            titleLabel.text = title
            titleLabel.textColor = titleColor ?? DefaultTitleColor
            titleLabel.font = titleFont ?? DefaultTitleFont
        } else {
            imageView.image = selectedImage
            titleLabel.text = selectedTitle
            titleLabel.textColor = selectedTitleColor ?? DefaultSelectedTitleColor
            titleLabel.font = selectedTitleFont ?? DefaultTitleFont
        }
        
        updateLayout()
    }
    
    /// 计算文字的需要的高度
    func height(for text: String) -> CGFloat {
        
        let font = titleFont ?? DefaultTitleFont
        
        let textRect = (text as NSString).boundingRect(with: CGSize(width: frame.width, height: 9999), options: .usesFontLeading, attributes: [.font: font], context: nil)
        return textRect.size.height
    }
    
}

// MARK: - Getter Setter
fileprivate extension CVTabBarItem {
    
    func _isSelectedDidSet() {
        updateState()
    }
    
    func _imageView() -> UIImageView {
        let iv = UIImageView(frame: CGRect.zero)
        iv.contentMode = .scaleAspectFit
        return iv
    }
    
    func _titleLabel() -> UILabel {
        let lb = UILabel(frame: CGRect.zero)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }
    
    func _paopao() -> CVPaopao {
        let po = CVPaopao(frame: CGRect.zero)
        po.isHidden = true
        return po
    }
    
    func _button() -> UIButton {
        let bt = UIButton(type: .custom)
        bt.frame = bounds
        bt.addTarget(self, action: #selector(onClickTouchAction(sender:)), for: .touchUpInside)
        return bt
    }
    
}
