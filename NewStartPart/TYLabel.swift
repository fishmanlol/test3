//
//  TYLabel.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYLabel: UILabel {
    
    private var _text: NSAttributedString?
    
    var attributes: [NSAttributedString.Key: Any] = [:]
    
    //overrides
    override var text: String? {
        get {
            return _text?.string
        }
        
        set {
            guard let newValue = newValue else { return }
            _text = NSAttributedString(string: newValue, attributes: attributes)
        }
    }
    
    override var textColor: UIColor! {
        get {
            guard let color = attributes[NSAttributedString.Key.foregroundColor] as? UIColor else { return super.textColor }
            return color
        }
        
        set {
            attributes[NSAttributedString.Key.foregroundColor] = newValue
        }
    }
    
    override var font: UIFont! {
        get {
            guard let f = attributes[NSAttributedString.Key.font] as? UIFont else { return super.font }
            return f
        }
        
        set {
            attributes[NSAttributedString.Key.font] = newValue
        }
    }
    
    //self-owned
    var kern: CGFloat {
        get {
            guard let k = attributes[NSAttributedString.Key.kern] as? CGFloat else { return 0 }
            return k
        }
        
        set {
            attributes[NSAttributedString.Key.kern] = newValue
        }
    }
    
    
}
