//
//  TYNormalInput.swift
//  NewStartPart
//
//  Created by tongyi on 7/7/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit
import PhoneNumberKit

enum InputType {
    case normal, password, phoneNumber
}

class TYNormalInput: TYInput {
    private var secureButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    private var codeButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.red]
    weak var textField: TYTextField!
    var inputType: InputType!
    var country: Country = Country.defaultCountry
    lazy var phoneNumberKit: PhoneNumberKit = {
        let kit = PhoneNumberKit()
        return kit
    }()
    
    var text: String? {
        get {
            return textField.text
        }
        
        set {
            textField.text = newValue
        }
    }
    
    var textFont: UIFont? {
        get {
            return textField.font
        }
        
        set {
            textField.font = newValue
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
    
    var textColor: UIColor? {
        get {
            return textField.textColor
        }
        
        set {
            textField.textColor = newValue
        }
    }
    
    lazy var secureButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedHide = NSAttributedString(string: "hide", attributes: secureButtonAttributes)
        let attributedShow = NSAttributedString(string: "show", attributes: secureButtonAttributes)
        button.setAttributedTitle(attributedHide, for: .normal)
        button.setAttributedTitle(attributedShow, for: .selected)
        button.frame.size = CGSize(width: 50, height: textField!.height)
        button.addTarget(self, action: #selector(secureButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var codeButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSAttributedString(string: country.shortNameAndCodeString(), attributes: codeButtonAttributes)
        button.setAttributedTitle(attributedText, for: .normal)
        button.frame.size = CGSize(width: attributedText.size().width + 20, height: height)
        button.addTarget(self, action: #selector(codeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(frame: CGRect, type: InputType = .normal) {
        super.init(frame: frame)
        
        let textField = TYTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField = textField
        self.textAreaView = textField
        addSubview(textField)
        
        switch type {
        case .normal:
            break
        case .password:
            textField.rightView = secureButton
            textField.rightViewMode = .always
        case .phoneNumber:
            textField.leftView = codeButton
            textField.leftViewMode = .always
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func secureButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideText(sender.isSelected)
    }
    
    @objc private func codeButtonTapped() {
        displayCountryListController()
    }
    
    private func hideText(_ hide: Bool) {
        textField!.isSecureTextEntry = hide ? true : false
    }
    
    private func updateCodeButton() {
        let attributedText = NSAttributedString(string: country.shortNameAndCodeString(), attributes: codeButtonAttributes)
        
        codeButton.setAttributedTitle(attributedText, for: .normal)
        codeButton.frame.size = CGSize(width: attributedText.size().width + 20, height: height)
    }
    
    private func displayCountryListController() {
        let countryListController = CountryListController()
        
        let currentViewController = UIApplication.shared.keyWindow?.rootViewController
    }
}
