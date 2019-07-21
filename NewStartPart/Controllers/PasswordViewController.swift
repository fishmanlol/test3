//
//  PasswordController.swift
//  StartPart
//
//  Created by tongyi on 6/30/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class PasswordViewController: StartBaseViewController {
    
    weak var titleLabel: TYLabel!
    weak var descriptionLabel: TYLabel!
    weak var errorLabel: TYLabel!
    weak var passwordInput: TYInput!
    weak var container: UILayoutGuide!
    
    let registrationInfo: RegistrationInfo
    
    init(registrationInfo: RegistrationInfo) {
        self.registrationInfo = registrationInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.registrationInfo = RegistrationInfo()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func nextButtonTapped(sender: TYButton) {
        registrationInfo.password = passwordInput.text
        
        let phoneNumberViewController = PhoneNumberViewController(flow: .registration(registrationInfo))
        navigationController?.pushViewController(phoneNumberViewController, animated: false)
    }
}

extension PasswordViewController: TYInputDelegate {
    func textFieldValueChanged(_ input: TYInput) {
        let password = input.text ?? ""
        if Validator.validPassword(password) {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
}

extension PasswordViewController { //Helper functions
    private func showError(_ error: String) {
        errorLabel.text = error
    }
    
    private func hideError() {
        errorLabel.text = ""
    }
    
    private func setup() {
        let titleLabel = TYLabel(frame: .zero)
        titleLabel.text = "Set a password"
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize)
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let descriptionLabel = TYLabel(frame: .zero)
        descriptionLabel.text = "Your password should be at least 8 characters"
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.middleFontSize)
        self.descriptionLabel = descriptionLabel
        view.addSubview(descriptionLabel)
        
        let passwordInput = TYInput(frame: CGRect.zero, type: .password(hide: false))
        passwordInput.labelText = "PASSWORD"
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet.init(charactersIn: #"?<>.;:[]{}-=_+~`!@#$%^&*(),/'\|"#))
        passwordInput.disallowedCharacterSet = allowedCharacterSet.inverted
        passwordInput.delegate = self
        self.passwordInput = passwordInput
        view.addSubview(passwordInput)
        
        let errorLabel = TYLabel(frame: .zero)
        errorLabel.numberOfLines = 0
        errorLabel.textColor = UIColor.red
        self.errorLabel = errorLabel
        view.addSubview(errorLabel)
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        container.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(160)
            make.left.equalToSuperview().offset(60)
            make.centerX.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(container)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        passwordInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(36)
            make.height.equalTo(60)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(passwordInput.snp.bottom).offset(6)
        }
    }
}
