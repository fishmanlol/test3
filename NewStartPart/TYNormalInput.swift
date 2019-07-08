//
//  TYNormalInput.swift
//  NewStartPart
//
//  Created by tongyi on 7/7/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class TYNormalInput: TYInput {
    private var secureButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    
    lazy var secureButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedHide = NSAttributedString(string: "hide", attributes: secureButtonAttributes)
        let attributedShow = NSAttributedString(string: "show", attributes: secureButtonAttributes)
        button.setAttributedTitle(attributedHide, for: .normal)
        button.setAttributedTitle(attributedShow, for: .selected)
        button.frame.size = CGSize(width: button.intrinsicContentSize.width + 10, height: textField!.height)
        button.addTarget(self, action: #selector(secureButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //Public
    var textKern: CGFloat {
        get {
            return textField!.kern
        }
        
        set {
            textField!.kern = newValue
        }
    }
    
    convenience init(frame: CGRect, hasSecureButton: Bool = false) {
        self.init(frame: frame)
        
        if hasSecureButton {
            textField!.rightView = secureButton
            textField!.rightViewMode = .always
        }
    }
    
    override init(frame: CGRect) {
        super.init(f: frame)
        viewsSetup()
        viewsLayout()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func viewsSetup() {

    }
    
    private func viewsLayout() {

    }
    
    private func setup() {
    
    }
    
    
    @objc private func secureButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideText(sender.isSelected)
    }
    
    private func hideText(_ hide: Bool) {
        textField!.isSecureTextEntry = hide ? true : false
    }

}
