//
//  TYTextField.swift
//  NewStartPart
//
//  Created by tongyi on 7/7/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYTextField: UITextField {
    
    private var bottomLineLayer: CALayer?
    
    //Bottom line
    var bottomLineHeight: CGFloat = 1.0 {
        didSet {
            updateBottomLineHeight(to: bottomLineHeight)
        }
    }
    
    var bottomLineColor: UIColor = UIColor.black {
        didSet {
            updateBottomLineColor(to: bottomLineColor)
        }
    }
    
    var kern: CGFloat {
        set {
            defaultTextAttributes[NSAttributedString.Key.kern] = newValue
        }
        
        get {
            return defaultTextAttributes[NSAttributedString.Key.kern] as? CGFloat ?? 0.0
        }
    }
    
    override var text: String! {
        get {
            return super.text ?? ""
        }
        
        set {
            attributedText = NSAttributedString(string: newValue, attributes: defaultTextAttributes)
        }
    }
    
    override var textColor: UIColor! {
        get {
            return super.textColor ?? tintColor
        }
        
        set {
            defaultTextAttributes[NSAttributedString.Key.foregroundColor] = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBottomLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addBottomLine() {
        let bottomLineLayer = CALayer()
        self.bottomLineLayer = bottomLineLayer
        updateBottomLineHeight(to: bottomLineHeight)
        updateBottomLineColor(to: bottomLineColor)
        layer.addSublayer(bottomLineLayer)
    }
    
    private func updateBottomLineHeight(to newHeight: CGFloat) {
        bottomLineLayer?.frame = CGRect(x: 0, y: height - newHeight, width: width, height: newHeight)
    }
    
    private func updateBottomLineColor(to newColor: UIColor) {
        bottomLineLayer?.backgroundColor = newColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateBottomLineHeight(to: bottomLineHeight)
    }
}
