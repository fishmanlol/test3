//
//  TYNormalInput.swift
//  NewStartPart
//
//  Created by tongyi on 7/7/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYNormalInput: TYInput {
    private weak var textField: TYTextField!
    private var bottomLineLayer: CALayer!
    
    lazy var secureButton: UIButton = {
        let button = UIButton(type: .system)
        textField.rightView = button
        return button
    }()
    
    //Public
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
    
    var textKern: CGFloat {
        get {
            return textField.kern
        }
        
        set {
            textField.kern = newValue
        }
    }
    
    private var hasSecureButton: Bool = false {
        didSet {
            
        }
    }
    
    //Overrides
    override var text: String! {
        get {
            return textField.text
        }

        set {
            textField.text = newValue
        }
    }
    
    override var textFont: UIFont! {
        get {
            return textField.font
        }
        
        set {
            textField.font = newValue
        }
    }
    
    override var textColor: UIColor! {
        get {
            return textField.textColor
        }
        
        set {
            textField.textColor = newValue
        }
    }
    
    convenience init(frame: CGRect, hasSecureButton: Bool = false) {
        self.init(frame: frame)
        
        if hasSecureButton {
            self.hasSecureButton = hasSecureButton
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewsSetup()
        viewsLayout()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func viewsSetup() {
        let textField = TYTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField = textField
        addSubview(textField)
    }
    
    private func viewsLayout() {
        textField.topAnchor.constraint(equalTo: textViewLayoutGuide.topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: textViewLayoutGuide.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: textViewLayoutGuide.rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: textViewLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setup() {
        addBottomLine()
    }
    
    private func addBottomLine() {
        let bottomLineLayer = CALayer()
        self.bottomLineLayer = bottomLineLayer
        updateBottomLineHeight(to: bottomLineHeight)
        updateBottomLineColor(to: bottomLineColor)
        layer.addSublayer(bottomLineLayer)
    }
    
    private func updateBottomLineHeight(to newHeight: CGFloat) {
        bottomLineLayer.frame = CGRect(x: 0, y: height - newHeight, width: width, height: newHeight)
    }
    
    private func updateBottomLineColor(to newColor: UIColor) {
        bottomLineLayer.backgroundColor = newColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateBottomLineHeight(to: bottomLineHeight)
    }
}
