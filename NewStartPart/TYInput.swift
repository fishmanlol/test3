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
    
    //Fonts
    public var labelFont: UIFont! {
        set {
            label.font = newValue
        }
        
        get {
            return label.font
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
    var label: TYLabel!
    lazy var textAreaView: UIView = {
        let textAreaView = UIView()
        textAreaView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textAreaView)
        return textAreaView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        let label = TYLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.label = label
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        textAreaView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textAreaView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textAreaView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textAreaView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        textAreaView.heightAnchor.constraint(equalToConstant: 24).priority = .defaultHigh
    }
}
