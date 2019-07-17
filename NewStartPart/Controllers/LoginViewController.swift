//
//  LoginViewController.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/16/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class LoginViewController: StartBaseViewController {
    weak var container: UILayoutGuide!
    weak var titleLabel: TYLabel!
    weak var phoneNumberInput: TYInput!
    weak var passwordInput: TYInput!
    weak var errorLabel: TYLabel!
    weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc private func forgotPasswordButtonTapped(sender: UIButton) {
        
    }
}

extension LoginViewController: TYInputDelegate {
    func textField(_ input: TYInput, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension LoginViewController { //Network call
    
}

extension LoginViewController { //Helper functions
    private func setup() {
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        let titleLabel = TYLabel(frame: CGRect.zero)
        titleLabel.text = "Log In"
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize)
        titleLabel.textColor = UIColor.black
        
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let phoneNumberInput = TYInput(frame: CGRect.zero, type: .phoneNumber)
        phoneNumberInput.delegate = self
        phoneNumberInput.labelText = "MOBILE NUMBER"
        self.phoneNumberInput = phoneNumberInput
        view.addSubview(phoneNumberInput)
        
        let passwordInput = TYInput(frame: CGRect.zero, type: .password(hide: true))
        passwordInput.labelText = "PASSWORD"
        self.passwordInput = passwordInput
        view.addSubview(passwordInput)
        
        let errorLabel = TYLabel(frame: CGRect.zero)
        errorLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.smallFontSize)
        errorLabel.textColor = UIColor.red
        self.errorLabel = errorLabel
        view.addSubview(errorLabel)
        
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Forgot your password?", for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        self.forgotPasswordButton = forgotPasswordButton
        view.addSubview(forgotPasswordButton)
        
        container.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(container)
        }
        
        phoneNumberInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.height.equalTo(60)
        }
        
        passwordInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(phoneNumberInput.snp.bottom).offset(18)
            make.height.equalTo(60)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(passwordInput.snp.bottom).offset(6)
        }
        
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(container)
            make.top.equalTo(errorLabel.snp.bottom).offset(14)
        }
    }
}
