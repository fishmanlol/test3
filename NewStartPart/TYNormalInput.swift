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
    var codeButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor(r: 79, g: 170, b: 248), NSAttributedString.Key.font: UIFont.avenirNext(bold: .medium, size: 17)]
    weak var textField: TYTextField!
    let inputType: InputType
    
    var country: Country = Country.defaultCountry {
        didSet {
            updateCodeContainerSize(for: country)
            updateCodeButtonTitle()
            updatePhoneNumberFormat()
        }
    }
    
    lazy var phoneNumberKit: PhoneNumberKit = {
        let kit = PhoneNumberKit()
        return kit
    }()
    
    var phoneNumber: PhoneNumber?
    
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
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    override var isFirstResponder: Bool {
        return textField.isFirstResponder
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
    
    lazy var codeContainer: UIView = {
        let view = UIView()
        let attributedText = NSAttributedString(string: country.shortNameAndCodeString(), attributes: codeButtonAttributes)
        let size = CGSize(width: attributedText.size().width + 14, height: textField.height)
        view.frame.size = CGSize(width: size.width, height: textAreaHeight)
        return view
    }()
    
    lazy var codeButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSAttributedString(string: country.shortNameAndCodeString(), attributes: codeButtonAttributes)
        button.setAttributedTitle(attributedText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(codeButtonTapped), for: .touchUpInside)
        codeContainer.addSubview(button)
        return button
    }()
    
    lazy var separateLine: UIView = {
        let separateLine = UIView()
        separateLine.backgroundColor = UIColor(r: 207, g: 212, b: 217)
        separateLine.translatesAutoresizingMaskIntoConstraints = false
        codeContainer.addSubview(separateLine)
        return separateLine
    }()
    
    init(frame: CGRect, type: InputType = .normal) {
        inputType = type
        
        super.init(frame: frame)
        
        let textField = TYTextField()
        textField.kern = 1.2
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        self.textField = textField
        self.textAreaView = textField
        addSubview(textField)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        inputType = .normal
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        
        switch inputType {
        case .normal:
            break
        case .password:
            textField.rightView = secureButton
            textField.rightViewMode = .always
        case .phoneNumber:
            textField.leftView = codeContainer
            textField.leftViewMode = .always
            textField.keyboardType = .numberPad
            textField.tintColor = UIColor(r: 79, g: 170, b: 248)
        }
        
        codeButton.leftAnchor.constraint(equalTo: codeContainer.leftAnchor).isActive = true
        codeButton.topAnchor.constraint(equalTo: codeContainer.topAnchor).isActive = true
        codeButton.bottomAnchor.constraint(equalTo: codeContainer.bottomAnchor).isActive = true
        
        separateLine.topAnchor.constraint(equalTo: codeContainer.topAnchor, constant: 4).isActive = true
        separateLine.centerYAnchor.constraint(equalTo: codeContainer.centerYAnchor).isActive = true
        separateLine.widthAnchor.constraint(equalToConstant: 1.2).isActive = true
        separateLine.leftAnchor.constraint(equalTo: codeButton.rightAnchor, constant: 5).isActive = true
    }
    
    @objc private func secureButtonTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideText(sender.isSelected)
    }
    
    @objc private func codeButtonTapped() {
        displayCountryListController()
    }
    
    @objc private func valueChanged() {
        if inputType == InputType.phoneNumber {
            updatePhoneNumberFormat()
        }
    }
    
    private func hideText(_ hide: Bool) {
        textField!.isSecureTextEntry = hide ? true : false
    }
    
    private func updateCodeButtonTitle() {
        let attributedText = NSAttributedString(string: country.shortNameAndCodeString(), attributes: codeButtonAttributes)
        
        codeButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    private func updateCodeContainerSize(for country: Country) {
        let attributedText = NSAttributedString(string: country.shortNameAndCodeString(), attributes: codeButtonAttributes)
        codeContainer.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: attributedText.size().width + 12, height: textField.height))
        print(codeContainer.frame)
        if textField.isFirstResponder {
            let _ = resignFirstResponder()
            let _ = becomeFirstResponder()
        } else {
            let _ = becomeFirstResponder()
            let _ = resignFirstResponder()
        }
    }
    
    private func displayCountryListController() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let visibleController = appDelegate.getVisbleViewController() else { return }
        
        let countryListController = CountryListController(from: self)
        let navController = UINavigationController(rootViewController: countryListController)
        visibleController.present(navController, animated: true, completion: nil)
    }
    
    private func updatePhoneNumberFormat() {
        guard let text = text else { return }
        
        if let phoneNumber = try? phoneNumberKit.parse(text, withRegion: country.shortName, ignoreType: true) {
            let numberFormatted = phoneNumberKit.format(phoneNumber, toType: .national, withPrefix: false)
            //sometimes formatter will automatically convert our input to most possible number, but we don't want to change use's input.
            //if input: 9491313313, formatter give us (949) 131-3313
            //if input: 94913133130, formatter give us 0913 133 130
            //we compare first 3 number to decide whether we need this format
            let numberFormattedFiltered = numberFormatted.onlyNumber
            let commonPrefix = numberFormattedFiltered.commonPrefix(with: text)
            if commonPrefix.count > 2 {
                //we need display this formatted number and save
                self.phoneNumber = phoneNumber
                self.text = numberFormatted
            } else {
                //discard
                self.phoneNumber = nil
                self.text = text.onlyNumber
            }
        } else {
            self.phoneNumber = nil
            self.text = text.onlyNumber
        }
    }
}
