//
//  TYTextField.swift
//  NewStartPart
//
//  Created by tongyi on 7/7/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYTextField: UITextField {
    
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
}
