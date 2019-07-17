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
    private var tempColor = UIColor.clear
    
    var disabledBackgroudColor: UIColor = UIColor.darkGray
    
    var isLoading: Bool {
        get {
            return spin.isAnimating
        }
    }
    
    private lazy var spin: SpinView = {
        let spin = SpinView()
        spin.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        spin.bounds.size = CGSize(width: 28, height: 28)
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
        setAttributedTitle(NSAttributedString(string: currentAttributedTitle?.string ?? "", attributes: attributes), for: state)
    }
    
    override func titleColor(for state: UIControl.State) -> UIColor? {
        return attributes[NSAttributedString.Key.foregroundColor] as? UIColor
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
        setTitleColor(UIColor.white, for: .normal)
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height * 0.5
    }
    
    private func hideTitleLabel() {
        tempColor = currentTitleColor
        titleLabel?.textColor = .clear
    }
    
    private func restoreTitleLabel() {
        titleLabel?.textColor = tempColor
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isLoading {
            return nil
        } else {
            return super.hitTest(point, with: event)
        }
    }
}
