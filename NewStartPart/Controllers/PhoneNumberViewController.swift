//
//  PhoneNumberViewController.swift
//  StartPart
//
//  Created by tongyi on 6/30/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneNumberViewController: StartBaseViewController {
    
    weak var titleLabel: TYLabel!
    weak var phoneNumberInput: TYInput!
    weak var remindLabel: TYLabel!
    weak var container: UILayoutGuide!
    
    var flow: Flow!
    
    init(flow: Flow) {
        self.flow = flow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func nextButtonTapped(sender: TYButton) {
        guard let phoneNumberString = phoneNumberInput.phoneNumber?.formattedString else {
            nextButton.isEnabled = false
            return
        }
        checkPhoneNumberExist(phoneNumberString) { [weak self] (exist) in
            guard let weakSelf = self else { return }
            
            if exist {
                switch weakSelf.flow! {
                case .forgotPassword:
                    weakSelf.sendVerificationCode(to: phoneNumberString)
                case .registration(_):
                    weakSelf.stopLoading {
                        weakSelf.displayAlert(title: "User Exists", msg: "if you own this mobile number now, you can continue registration.(All data will be erased after new account registered)", hasCancel: true, actionStyle: .destructive, actionTitle: "Continue") {
                            weakSelf.startLoading()
                            weakSelf.sendVerificationCode(to: phoneNumberString)
                        }
                    }
                }
            } else {
                switch weakSelf.flow! {
                case .forgotPassword:
                    weakSelf.stopLoading {
                        weakSelf.showError("User does not exist")
                    }
                case .registration(_):
                    weakSelf.sendVerificationCode(to: phoneNumberString)
                }
            }
        }
    }
    
    deinit {
        print(#function)
    }
}

extension PhoneNumberViewController { //Network calling
    private func checkPhoneNumberExist(_ phoneNumber: String, completion: @escaping (Bool) -> Void) {
        startLoading()
        APIService.shared.isPhoneNumberExists(phoneNumber: phoneNumber) { [weak self] (success, error, result) in
            guard let weakSelf = self else { return }
            guard success, let result = result else {
                weakSelf.stopLoading {
                    weakSelf.showError(error?.errorMessage ?? ErrorDetail.generalErrorMessage)
                }
                return
            }
            
            if result.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    private func sendVerificationCode(to phoneNumber: String) {
        APIService.shared.sendVerficationCode(phoneNumber: phoneNumber) { [weak self] (success, error) in
            guard let weakSelf = self else { return }
            weakSelf.stopLoading {
                if !success {
                    weakSelf.showError(error?.errorMessage ?? ErrorDetail.generalErrorMessage)
                } else {
                    switch weakSelf.flow! {
                    case .forgotPassword(let forgotPasswordInfo):
                        forgotPasswordInfo.phoneNumber = phoneNumber
                        let phoneVerificationViewController = PhoneVerificationViewController(flow: .forgotPassword(forgotPasswordInfo))
                        weakSelf.navigationController?.pushViewController(phoneVerificationViewController, animated: false)
                    case .registration(let registrationInfo):
                        registrationInfo.phoneNumber = phoneNumber
                        let phoneVerificationViewController = PhoneVerificationViewController(flow: .registration(registrationInfo))
                        weakSelf.navigationController?.pushViewController(phoneVerificationViewController, animated: false)
                    }
                }
            }
        }
    }
}

extension PhoneNumberViewController: TYInputDelegate {
    func textFieldValueChanged(_ input: TYInput) {
        hideError()
        if input.phoneNumber != nil {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
}

extension PhoneNumberViewController { //Helper functions
    private func showError(_ error: String) {
        remindLabel.textColor = .red
        remindLabel.text = error
    }
    
    private func hideError() {
        remindLabel.textColor = .black
        remindLabel.text = "We'll send you an SMS verification code."
    }
    
    private func setup() {
        let titleLabel = TYLabel(frame: .zero)
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize)
        titleLabel.text = "What's your\nmobile number?"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let phoneNumberInput = TYInput(frame: .zero, type: .phoneNumber)
        phoneNumberInput.labelText = "PHONE NUMBER"
        phoneNumberInput.labelColor = .lightBlue
        phoneNumberInput.delegate = self
        self.phoneNumberInput = phoneNumberInput
        view.addSubview(phoneNumberInput)
        
        let remindLabel = TYLabel(frame: .zero)
        remindLabel.text = "We'll send you an SMS verification code."
        remindLabel.numberOfLines = 0
        remindLabel.kern = 0.5
        remindLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.smallFontSize)
        self.remindLabel = remindLabel
        view.addSubview(remindLabel)
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        container.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(160)
            make.left.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(container)
        }
        
        phoneNumberInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.height.equalTo(60)
        }
        
        remindLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(phoneNumberInput.snp.bottom).offset(6)
        }
    }
}
