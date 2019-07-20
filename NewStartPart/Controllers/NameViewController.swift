//
//  NameViewController.swift
//  StartPart
//
//  Created by Yi Tong on 6/28/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit
import SnapKit

class NameViewController: StartBaseViewController {
    
    weak var container: UILayoutGuide!
    weak var titleLabel: TYLabel!
    weak var agreementLabel: TYLabel!
    weak var firstNameInput: TYInput!
    weak var lastNameInput: TYInput!
    
    let registrationInfo = RegistrationInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func nextButtonTapped(sender: TYButton) {
        registrationInfo.firstName = firstNameInput.text ?? ""
        registrationInfo.lastName = lastNameInput.text ?? ""
        
        navigationController?.pushViewController(PasswordViewController(registrationInfo: registrationInfo), animated: false)
    }
}

extension NameViewController: TYInputDelegate {
    func textFieldValueChanged(_ input: TYInput) {
        let firstName = firstNameInput.text ?? ""
        let lastName = lastNameInput.text ?? ""
        if Validator.validName(firstName) && Validator.validName(lastName) {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
}

extension NameViewController {//Helper functions
    private func setup() {
        nextButton.setTitle("Sign Up & Accept", for: .normal)
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        let titleLabel = TYLabel(frame: CGRect.zero)
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize)
        titleLabel.text = "What's your name?"
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let firstNameInput = TYInput(frame: CGRect.zero)
        firstNameInput.labelText = "FIRST NAME"
        firstNameInput.disallowedCharacterSet = CharacterSet.whitespacesAndNewlines.union(CharacterSet.decimalDigits)
        firstNameInput.delegate = self
        self.firstNameInput = firstNameInput
        view.addSubview(firstNameInput)
        
        let lastNameInput = TYInput(frame: CGRect.zero)
        lastNameInput.labelText = "LAST NAME"
        lastNameInput.disallowedCharacterSet = CharacterSet.whitespacesAndNewlines.union(CharacterSet.decimalDigits)
        lastNameInput.delegate = self
        self.lastNameInput = lastNameInput
        view.addSubview(lastNameInput)
        
        let agreementLabel = TYLabel(frame: CGRect.zero, clickable: true)
        agreementLabel.numberOfLines = 0
        agreementLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.smallFontSize)
        let agreementString = "By tapping Sign Up & Accept, you acknowledge that you have read the Privacy Policy and agree to the Term of Service."
        agreementLabel.text = agreementString
        self.agreementLabel = agreementLabel
        view.addSubview(agreementLabel)
        if let privacyRange =  agreementString.range(of: "Privacy Policy"), let tosRange =  agreementString.range(of: "Term of Service") {
            print(privacyRange)
            agreementLabel.makeClickable(at: privacyRange) { [weak self] (title) in
                let navController = UINavigationController(rootViewController: AgreementViewController(agreement: .privacy))
                self?.present(navController, animated: true, completion: nil)
            }
            
            agreementLabel.makeClickable(at: tosRange) { [weak self] (title) in
                let navController = UINavigationController(rootViewController: AgreementViewController(agreement: .tos))
                self?.present(navController, animated: true, completion: nil)
            }
        }
        
        container.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(container)
        }
        
        firstNameInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.height.equalTo(60)
        }
        
        lastNameInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(firstNameInput.snp.bottom).offset(18)
            make.height.equalTo(60)
        }
        
        agreementLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(lastNameInput.snp.bottom).offset(6)
        }
        
    }
}
