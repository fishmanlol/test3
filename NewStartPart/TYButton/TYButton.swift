//
//  UIButton.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/12/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYButton: UIButton {
    private var attributes: [NSAttributedString.Key: Any]
    private(set) var isLoading: Bool
    
    public func startAnimating() {
        if isLoading { return }
        
        
    }
    
    public func stopAnimating() {
        if !isLoading { return }
        
        
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        
        setAttributedTitle(NSAttributedString(string: title ?? "", attributes: attributes), for: state)
    }
    
    override func title(for state: UIControl.State) -> String? {
        return attributedTitle(for: state)?.string
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
        setup()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        setup()
        super.init(coder: coder)
    }
    
    private func setup() {
        attributes = [NSAttributedString.Key.kern: 10]
        isLoading = false
    }
    
}
