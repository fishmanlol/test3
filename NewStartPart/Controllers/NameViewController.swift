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
    
}

extension NameViewController {//Helper functions
    private func setup() {
        nextButton.setTitle("Sign Up & Accept", for: .normal)
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        let titleLabel = TYLabel(frame: CGRect.zero)
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let firstNameInput = TYInput(frame: CGRect.zero)
        self.firstNameInput = firstNameInput
        view.addSubview(firstNameInput)
        
        let lastNameInput = TYInput(frame: CGRect.zero)
        self.lastNameInput = lastNameInput
        view.addSubview(lastNameInput)
        
        let agreementLabel = TYLabel(frame: CGRect.zero, clickable: true)
        let agreementString = "By tapping Sign Up & Accept, you acknowledge that you have read the Privacy Policy and agree to the Term of Service"
//        agreementLabel.text = agreementString
        if let privacyRange =  agreementString.range(of: "Privacy Policy"), let tosRange =  agreementString.range(of: "Term of Service") {
            print(privacyRange)
            agreementLabel.makeClickable(at: privacyRange) { [weak self] (title) in
                self?.present(AgreementViewController(agreement: .privacy), animated: true, completion: nil)
            }
            
            agreementLabel.makeClickable(at: tosRange) { [weak self] (title) in
                self?.present(AgreementViewController(agreement: .tos), animated: true, completion: nil)
            }
        }
        
        container.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(60)
        }
        
        firstNameInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
        }
        
        lastNameInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(firstNameInput.snp.bottom).offset(18)
        }
        
        agreementLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(lastNameInput.snp.bottom)
        }
        
    }
}
