//
//  UIButton.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/12/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYButton: UIButton {
    private var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.kern: 1]
    
    var disabledBackgroudColor: UIColor = UIColor.lightGray
    
    var isLoading: Bool {
        get {
            return spin.isAnimating
        }
    }
    
    private lazy var spin: SpinView = {
        let spin = SpinView()
        addSubview(spin)
        return spin
    }()
    
    public func startAnimating() {
        if isLoading { return }
        
        spin.startAnimating()
        hideTitleLabel()
    }
    
    public func stopAnimating() {
        if !isLoading { return }
        
        spin.stopAnimating()
        restoreTitleLabel()
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        
        setAttributedTitle(NSAttributedString(string: title ?? "", attributes: attributes), for: state)
    }
    
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        
        attributes[NSAttributedString.Key.foregroundColor] = color
        setAttributedTitle(NSAttributedString(string: currentTitle, attributes: attributes), for: state)
    }
    
    override func titleColor(for state: UIControl.State) -> UIColor? {
        return attributes[NSAttributedString.Key.foregroundColor] as? UIColor
    }
    
    override var currentTitle: String {
        return currentAttributedTitle?.string ?? ""
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            setBackgroundImage(nil, for: .normal)
        }
    }
    
    var kern: CGFloat = 0 {
        didSet {
            attributes[NSAttributedString.Key.kern] = kern
            setAttributedTitle(NSAttributedString(string: currentTitle, attributes: attributes), for: .normal)
        }
    }
    
    var titleFont: UIFont? {
        didSet {
            attributes[NSAttributedString.Key.font] = titleFont
            setAttributedTitle(NSAttributedString(string: currentTitle, attributes: attributes), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        setBackgroundImage(UIImage.from(UIColor(r: 59, g: 143, b: 206)), for: .normal)
        setBackgroundImage(UIImage.from(disabledBackgroudColor), for: .disabled)
        spin.lineColor = UIColor(r: 59, g: 143, b: 206)
        setTitleColor(UIColor.white, for: .normal)
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height * 0.5
        spin.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
    }
    
    private func hideTitleLabel() {
        titleLabel?.layer.opacity = 0
    }
    
    private func restoreTitleLabel() {
        titleLabel?.layer.opacity = 1
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isLoading {
            return nil
        } else {
            return super.hitTest(point, with: event)
        }
    }
}
