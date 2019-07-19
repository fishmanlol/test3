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
}

extension PhoneVerificationViewController { //Helper functions
    private func setup() {
        let titleLabel = TYLabel(frame: .zero)
        titleLabel.text = "Enter Confirmation Code"
        titleLabel.font = UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        
        let descriptionLabel = TYLabel(frame: .zero, clickable: true)
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.middleFontSize)
        descriptionLabel.clickableAttributes = [NSAttributedString.Key.font: UIFont.avenirNext(bold: .medium, size: UIFont.middleFontSize), NSAttributedString.Key.foregroundColor: UIColor.black]
        self.descriptionLabel = descriptionLabel
        view.addSubview(descriptionLabel)
        
        if case let .registration(registrationInfo) = flow , let phoneNumberString = registrationInfo.phoneNumber {
            descriptionLabel.text = "Enter the code we send to\n\(phoneNumberString)"
            if let range = descriptionLabel.text!.range(of: phoneNumberString) {
                descriptionLabel.makeClickable(at: range) { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        let codeInput = TYInput(frame: .zero, type: .pinCode)
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
            make.top.equalTo(descriptionLabel).offset(36)
            make.height.equalTo(60)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(codeInput.snp.bottom).offset(6)
        }
    }
}

extension PhoneVerificationViewController: TYInputDelegate {
    
}
