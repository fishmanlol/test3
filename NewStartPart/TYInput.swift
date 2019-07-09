//
//  TYInput.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

internal class TYInput: UIView {
    
    //Strings
    public var labelText: String! {
        set {
            label.text = newValue
        }
        
        get {
            return label.text ?? ""
        }
    }
    
    public var text: String {
        get {
            return textAreaView._text
        }
        
        set {
            textAreaView._text = newValue
        }
    }
    
    //Fonts
    public var labelFont: UIFont! {
        set {
            label.font = newValue
        }
        
        get {
            return label.font
        }
    }
    public var textFont: UIFont {
        get {
            return textAreaView._textFont
        }
        
        set {
            textAreaView._textFont = newValue
        }
    }
    
    //Colors
    public var labelColor: UIColor! {
        set {
            label.textColor = newValue
        }
        
        get {
            return label.textColor
        }
    }
    
    public var textColor: UIColor {
        get {
            return textAreaView._textColor
        }
        
        set {
            textAreaView._textColor = newValue
        }
    }
    
    //Kern
    public var labelKern: CGFloat {
        set {
            label.kern = newValue
        }
        
        get {
            return label.kern
        }
    }
    
    public var textKern: CGFloat {
        set {
            textAreaView._kern = newValue
        }
        
        get {
            return textAreaView._kern
        }
    }
    
    //Views
    internal var label: TYLabel!
    internal var textAreaView: TextAreaView!
    
    init(frame: CGRect, textAreaView: TextAreaView) {
        super.init(frame: frame)
        
        let label = TYLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.label = label
        addSubview(label)
        
        self.textAreaView = textAreaView
        (textAreaView as! UIView).translatesAutoresizingMaskIntoConstraints = false
        addSubview((textAreaView as! UIView))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(greaterThanOrEqualTo: (textAreaView as! UIView).topAnchor).isActive = true
        
        (textAreaView as! UIView).leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        (textAreaView as! UIView).rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        (textAreaView as! UIView).bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        (textAreaView as! UIView).heightAnchor.constraint(equalToConstant: 24).isActive = true
        (textAreaView as! UIView).heightAnchor.constraint(equalToConstant: 24).priority = .defaultHigh
    }
}
