//
//  CVBarButtonItem.swift
//  CVBaseKit
//
//  Created by caven on 2018/12/1.
//  Copyright © 2018 caven-twy. All rights reserved.
//

import UIKit


private let DefaultHeight: CGFloat = 40
private let DefaultMarginLR: CGFloat = 5
private let DefaultSpace: CGFloat = 5


open class CVBarButtonItem: CVBarItem {
    
    public var font: UIFont? { didSet { _fontDidSet() } }
    public var textColor: UIColor? { didSet { _textColorDidSet() } }
    public var text: String? { didSet { _textDidSet() } }
    
    public var image: UIImage? { didSet { _imageDidSet() } }
    
    public weak var target: AnyObject? { didSet { _targetDidSet() } }
    public var action: Selector? { didSet { _actionDidSet() } }
    
    lazy private var titleLabel: UILabel = { return _titleLabel() }()
    lazy private var imageView: UIImageView = { return _imageView() }()
    lazy private var button: UIButton = { return _button() }()
    private let appearance = CVNavigationAppearance.share
    
}

// MARK: - Life Cycle
extension CVBarButtonItem {
    convenience init(title: String?, target: AnyObject?, action: Selector?) {
        self.init()
        self.text = title
        self.target = target
        self.action = action
        
        _textDidSet()
        _targetDidSet()
        _actionDidSet()
    }
    
    convenience init(image: UIImage?, target: AnyObject?, action: Selector?) {
        self.init()
        self.image = image
        self.target = target
        self.action = action
        
        _imageDidSet()
        _targetDidSet()
        _actionDidSet()
    }
    
    convenience init(title: String?, image: UIImage?, target: AnyObject?, action: Selector?) {
        self.init()
        self.text = title
        self.image = image
        self.target = target
        self.action = action
        
        _textDidSet()
        _imageDidSet()
        _targetDidSet()
        _actionDidSet()
    }
    
    open override func layoutSubviews() {
        layoutFrame()
    }
}

// MARK: - Public Methods
fileprivate extension CVBarButtonItem {
    
}

// MARK: - Private Methods
fileprivate extension CVBarButtonItem {
    
    /// 更新frame
    func layoutFrame() {
        
        let textSize: CGSize = size(for: text)
        let imageSize: CGSize = size(for: image)
        let itemSize = CGSize(width: DefaultMarginLR * 2 + textSize.width + imageSize.width + DefaultSpace, height: DefaultHeight)
        
        // 设置自己的size
        frame = CGRect(origin: frame.origin, size: itemSize)
        
        
        // 设置image的size
        if !imageSize.equalTo(CGSize.zero) {
            imageView.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
            let centerOff_x: CGFloat = DefaultMarginLR + imageSize.width / 2
            imageView.center = CGPoint(x: centerOff_x, y: DefaultHeight / 2)
        }
        // 设置title的size
        if !textSize.equalTo(CGSize.zero) {
            titleLabel.frame = CGRect(x: DefaultMarginLR, y: 0, width: textSize.width, height: textSize.height)
            var centerOff_x: CGFloat = DefaultMarginLR + textSize.width / 2
            if !imageSize.equalTo(CGSize.zero) {
                centerOff_x = imageView.frame.maxX + textSize.width / 2 + DefaultSpace
            }
            titleLabel.center = CGPoint(x: centerOff_x, y: DefaultHeight / 2)
        }

        button.frame = self.bounds
    }
    
    /// 计算文字的需要的size
    func size(for text: String?) -> CGSize {
        guard text != nil else { return CGSize.zero }
        let textRect = (text! as NSString).boundingRect(with: CGSize(width: 9999, height: 9999), options: .usesFontLeading, attributes: [.font: titleLabel.font], context: nil)
        return textRect.size
    }
    
    /// 计算图片的size
    func size(for image: UIImage?) -> CGSize {
        var size: CGSize = CGSize.zero
        if let im = image {
            if im.size.height > DefaultHeight {
                let scale = DefaultHeight / im.size.height
                size = CGSize(width: im.size.width * scale, height: DefaultHeight)
            } else {
                size = im.size
            }
        }
        return size
    }
}

// MARK: - Getter Setter
fileprivate extension CVBarButtonItem {
    
    
    func _fontDidSet() {
        titleLabel.font = font ?? appearance.itemFont
        layoutSubviews()
    }
    
    func _textColorDidSet() {
        titleLabel.textColor = textColor ?? appearance.itemTextColor
    }
    
    func _textDidSet() {
        titleLabel.text = text
        text != nil ? addSubview(titleLabel) : titleLabel.removeFromSuperview()
        layoutSubviews()
    }
    
    func _imageDidSet() {
        imageView.image = image
        image != nil ? addSubview(imageView) : imageView.removeFromSuperview()
        layoutSubviews()
    }
    
    func _targetDidSet() {
        if action != nil && target != nil {
            button.removeTarget(nil, action: nil, for: .touchUpInside)
            button.addTarget(target!, action: action!, for: .touchUpInside)
        }
    }
    
    func _actionDidSet() {
        if action != nil && target != nil {
            button.removeTarget(nil, action: nil, for: .touchUpInside)
            button.addTarget(target!, action: action!, for: .touchUpInside)
        }
    }
    
    // MARK: -
    func _titleLabel() -> UILabel {
        let lb = UILabel(frame: CGRect.zero)
        lb.textColor = textColor ?? appearance.itemTextColor
        lb.numberOfLines = 0
        lb.lineBreakMode = .byTruncatingMiddle
        lb.font = font ?? appearance.itemFont
        return lb
    }
    
    func _button() -> UIButton {
        let bt = UIButton(type: .custom)
        insertSubview(bt, at: 0)
        return bt
    }
    
    func _imageView() -> UIImageView {
        let iv = UIImageView(frame: CGRect.zero)
        iv.contentMode = .scaleAspectFill
        return iv
    }
}
