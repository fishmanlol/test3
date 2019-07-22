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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        passwordInput.text = ""
    }
    
    @objc private func forgotPasswordButtonTapped(sender: UIButton) {
        navigationController?.pushViewController(PhoneNumberViewController(flow: .forgotPassword(ForgotPasswordInfo())), animated: false)
    }
    
    override func backButtonTapped(sender: UIButton) {
        navigationController?.pushViewControllerFromLeft(LandingViewController(), animated: true)
    }
    
    override func nextButtonTapped(sender: TYButton) {
        guard let phoneNumberString = phoneNumberInput.phoneNumber?.formattedString, let password = passwordInput.text else {
            nextButton.isEnabled = true
            return
        }
        
        login(phoneNumber: phoneNumberString, password: password)
    }
}

extension LoginViewController: TYInputDelegate {
    func textFieldValueChanged(_ input: TYInput) {
        hideError()//clear error message if displayed
        
        if nextButton.isLoading {//if loading, don't validate
            return
        }
        
        let password = passwordInput.text ?? ""
        if let _ = phoneNumberInput.phoneNumber, Validator.validPassword(password) { //input valid
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
}

extension LoginViewController { //Network call
    private func login(phoneNumber: String, password: String) {
        
        startLoading()
        
        APIService.shared.login(phoneNumber: phoneNumber, password: password) { [weak self] (success, error, result) in
            guard let weakSelf = self else { return }
            weakSelf.stopLoading {
                if !success {
                    if let error = error {
                        weakSelf.showError(error.errorMessage)
                    } else {
                        weakSelf.showError(ErrorDetail.generalErrorMessage)
                    }
                } else {
                    guard let userId = result?.userId, let jwt = result?.jwtToken, let tvToken = result?.tvToken, let tvId = result?.tvId else {
                        weakSelf.showError(ErrorDetail.generalErrorMessage)
                        return
                    }
                    
                    UserDefaults.save(userId: userId, jwt: jwt, tvToken: tvToken, tvId: tvId)
                    weakSelf.navigationController?.pushViewController(ViewController(), animated: false)
                }
            }
        }
    }
}

extension LoginViewController { //Helper functions
    
    private func showError(_ error: String) {
        errorLabel.text = error
    }
    
    private func hideError() {
        errorLabel.text = ""
    }
    
    private func setup() {
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        let titleLabel = TYLabel(frame: CGRect.zero)
        titleLabel.text = "Log In"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize)
        
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let phoneNumberInput = TYInput(frame: CGRect.zero, type: .phoneNumber)
        phoneNumberInput.delegate = self
        phoneNumberInput.labelColor = .lightBlue
        phoneNumberInput.labelText = "MOBILE NUMBER"
        self.phoneNumberInput = phoneNumberInput
        view.addSubview(phoneNumberInput)
        
        let passwordInput = TYInput(frame: CGRect.zero, type: .password(hide: true))
        passwordInput.delegate = self
        passwordInput.labelText = "PASSWORD"
        passwordInput.disallowedCharacterSet = CharacterSet.letters
        self.passwordInput = passwordInput
        view.addSubview(passwordInput)
        
        let errorLabel = TYLabel(frame: CGRect.zero)
        errorLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.smallFontSize)
        errorLabel.textColor = UIColor.red
        errorLabel.numberOfLines = 0
        errorLabel.kern = 0.5
        self.errorLabel = errorLabel
        view.addSubview(errorLabel)
        
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitleColor(.lightBlue, for: .normal)
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
            make.height.equalTo(40)
            make.width.equalTo(200)
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
