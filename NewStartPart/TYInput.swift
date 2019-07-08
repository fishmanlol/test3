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
            return textAreaView.text
        }
        
        set {
            textAreaView.text = newValue
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
            return textAreaView.textFont
        }
        
        set {
            textAreaView.textFont = newValue
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
            return textAreaView.textColor
        }
        
        set {
            textAreaView.textColor = newValue
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
            textAreaView.kern = newValue
        }
        
        get {
            return textAreaView.kern
        }
    }
    
    //Views
    internal var label: TYLabel!
    internal var textAreaView: TextAreaView!
    
    init(frame: CGRect, textAreaView: TextAreaView) {
        super.init(frame: frame)
        self.textAreaView = textAreaView
        viewsSetup()
        viewsLayout()
        setup()
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewsSetup()
        viewsLayout()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewsSetup()
    }
    
    private func viewsSetup() {
        let label = TYLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.label = label
        addSubview(label)
    }
    
    private func viewsLayout() {
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(greaterThanOrEqualTo: textAreaView.topAnchor).isActive = true
        
        textAreaView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textAreaView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textAreaView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textAreaView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        textAreaView.heightAnchor.constraint(equalToConstant: 24).priority = .defaultHigh
    }
    
    private func setup() {
        labelText = ""
        labelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelColor = UIColor.black
    }
    
    private func textFieldSetup() {
        let textField = TYTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField = textField
        addSubview(textField)
        
        textField.topAnchor.constraint(equalTo: textViewLayoutGuide.topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: textViewLayoutGuide.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: textViewLayoutGuide.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: textViewLayoutGuide.bottomAnchor).isActive = true
    }
}
