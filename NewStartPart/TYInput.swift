//
//  TYInput.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/3/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

internal class TYInput: UIView {
    
    //Parameters
    

    //Strings
    public var labelText: String! {
        set {
            label.text = newValue
        }
        
        get {
            return label.text ?? ""
        }
    }
    
    public var text: String!
    
    //Fonts
    public var labelFont: UIFont! {
        set {
            label.font = newValue
        }
        
        get {
            return label.font
        }
    }
    public var textFont: UIFont!
    
    //Colors
    public var labelColor: UIColor! {
        set {
            label.textColor = newValue
        }
        
        get {
            return label.textColor
        }
    }
    public var textColor: UIColor!
    
    //Kern
    public var labelKern: CGFloat {
        set {
            label.kern = newValue
        }
        
        get {
            return label.kern
        }
    }
    
    //Views
    internal var label: TYLabel!
    internal var textViewLayoutGuide: UILayoutGuide!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        viewsSetup()
        viewsLayout()
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewsSetup()
    }
    
    private func viewsSetup() {
        let label = TYLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.label = label
        addSubview(label)

        let textViewLayoutGuide = UILayoutGuide()
        self.textViewLayoutGuide = textViewLayoutGuide
        addLayoutGuide(textViewLayoutGuide)
    }
    
    private func viewsLayout() {
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(greaterThanOrEqualTo: textViewLayoutGuide.topAnchor).isActive = true
        
        textViewLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textViewLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textViewLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textViewLayoutGuide.heightAnchor.constraint(equalToConstant: 24).isActive = true
        textViewLayoutGuide.heightAnchor.constraint(equalToConstant: 24).priority = .defaultHigh
    }
    
    private func setup() {
        labelText = ""
        labelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelColor = UIColor.black
    }
}
