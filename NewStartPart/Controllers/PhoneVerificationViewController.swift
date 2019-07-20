//
//  PhoneVerificationViewController.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/18/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneVerificationViewController: StartBaseViewController {
    weak var container: UILayoutGuide!
    weak var titleLabel: TYLabel!
    weak var descriptionLabel: TYLabel!
    weak var codeInput: TYInput!
    weak var errorLabel: TYLabel!
    
    var flow: Flow!
    var timer: Timer?
    var lastSent: Date?
    var countDown = 10
    
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
        timerBegin(countDown: countDown)
    }
    
    override func nextButtonTapped(sender: TYButton) {
        timerBegin(countDown: countDown)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
}

extension PhoneVerificationViewController { //Network calling
    private func register(with info: RegistrationInfo) {
        let phoneNumber = info.phoneNumber ?? ""
        let verificationCode = info.phoneVerificationCode ?? ""
        let password = info.password ?? ""
        let firstName = info.firstName ?? ""
        let lastName = info.lastName ?? ""
        
        HUD.show("Verifying...")
        APIService.shared.register(phoneNumber: phoneNumber, verificationCode: verificationCode, password: password, firstName: firstName, middleName: nil, lastName: lastName) { [weak self] (success, error, result) in
            guard let weakSelf = self else { return }
            HUD.hide(min: 1)
            if !success {
                weakSelf.showError(error?.errorMessage ?? ErrorDetail.generalErrorMessage)
                let _ = weakSelf.codeInput.becomeFirstResponder()
                return
            }
            weakSelf.navigationController?.pushViewController(ViewController(), animated: false)
        }
    }
}

extension PhoneVerificationViewController: TYInputDelegate {
    func textFieldDidEndEditing(_ input: TYInput) {
        switch flow! {
        case .forgotPassword:
            break
        case .registration(let registrationInfo):
            if let codeTextField = input.textField as? TYCodeTextField,
                input.text?.count == codeTextField.digits {
                registrationInfo.phoneVerificationCode = input.text
                register(with: registrationInfo)
            }
        }
    }
    
    func textFieldValueChanged(_ input: TYInput) {
        hideError()
    }
}

extension PhoneVerificationViewController { //Helper functions
    private func elapse() -> Int {
        guard let lastSent = lastSent else { return Int.max }
        return abs(Int(lastSent.timeIntervalSinceNow))
    }
    
    private func timerBegin(countDown: Int) {
        lastSent = Date()
        nextButton.isEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let weakSelf = self else { return }
            let remain = countDown - weakSelf.elapse()
            if remain > 0 { //still in count down
                let label = "Resend(\(remain))s"
                weakSelf.nextButton.setTitle(label, for: .normal)
            } else { //timer over
                weakSelf.nextButton.setTitle("Resend", for: .normal)
                weakSelf.nextButton.isEnabled = true
                timer.invalidate()
            }
        }
        
        timer?.fire()
    }
    
    private func showError(_ error: String) {
        errorLabel.text = error
    }
    
    private func hideError() {
        errorLabel.text = ""
    }
    
    private func setup() {
        nextButton.setTitle("Resend", for: .normal)
        
        let titleLabel = TYLabel(frame: .zero)
        titleLabel.text = "Enter Confirmation Code"
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let descriptionLabel = TYLabel(frame: .zero, clickable: true)
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.middleFontSize)
        descriptionLabel.clickableAttributes = [NSAttributedString.Key.font: UIFont.avenirNext(bold: .medium, size: UIFont.middleFontSize)]
        self.descriptionLabel = descriptionLabel
        view.addSubview(descriptionLabel)
        
        if case let .registration(registrationInfo) = flow! , let phoneNumberString = registrationInfo.phoneNumber {
            descriptionLabel.text = "Enter the code we send to\n\(phoneNumberString)"
        }
        
        let codeInput = TYInput(frame: .zero, type: .pinCode)
        (codeInput.textField as? TYCodeTextField)?.fontSize = 20
        codeInput.labelText = "CODE"
        codeInput.labelColor = UIColor(r: 79, g: 170, b: 248)
        codeInput.delegate = self
        self.codeInput = codeInput
        view.addSubview(codeInput)
        
        let errorLabel = TYLabel(frame: .zero)
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.smallFontSize)
        self.errorLabel = errorLabel
        view.addSubview(errorLabel)
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        container.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(160)
            make.left.equalToSuperview().offset(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(container)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        codeInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(36)
            make.height.equalTo(60)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(codeInput.snp.bottom).offset(6)
        }
    }
}
