//
//  ResetPasswordViewController.swift
//  NewStartPart
//
//  Created by tongyi on 7/20/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class ResetPasswordViewController: StartBaseViewController {
    
    weak var titleLabel: TYLabel!
    weak var descriptionLabel: TYLabel!
    weak var errorLabel: TYLabel!
    weak var passwordInput: TYInput!
    weak var confirmInput: TYInput!
    weak var container: UILayoutGuide!
    
    private let forgotPasswordInfo: ForgotPasswordInfo
    
    init(forgotPasswordInfo: ForgotPasswordInfo) {
        self.forgotPasswordInfo = forgotPasswordInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.forgotPasswordInfo = ForgotPasswordInfo()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension ResetPasswordViewController: TYInputDelegate {
    
}

extension ResetPasswordViewController { //Helper functions
    private func setup() {
        let titleLabel = TYLabel(frame: .zero)
        titleLabel.text = "New Password"
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
        
        let passwordInput = TYInput(frame: CGRect.zero, type: .password(hide: true))
        passwordInput.labelText = "NEW PASSWORD"
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet.init(charactersIn: #"?<>.;:[]{}-=_+~`!@#$%^&*(),/'\|"#))
        passwordInput.disallowedCharacterSet = allowedCharacterSet.inverted
        passwordInput.delegate = self
        self.passwordInput = passwordInput
        view.addSubview(passwordInput)
        
        let confirmInput = TYInput(frame: CGRect.zero, type: .password(hide: true))
        confirmInput.labelText = "CONFIRM PASSWORD"
        confirmInput.disallowedCharacterSet = allowedCharacterSet.inverted
        confirmInput.delegate = self
        self.confirmInput = confirmInput
        view.addSubview(confirmInput)
        
        let errorLabel = TYLabel(frame: .zero)
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.avenirNext(bold: .regular, size: UIFont.smallFontSize)
        errorLabel.textColor = .red
        self.errorLabel = errorLabel
        view.addSubview(errorLabel)
        
        let container = UILayoutGuide()
        self.container = container
        view.addLayoutGuide(container)
        
        container.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(container)
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
        
        confirmInput.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(passwordInput.snp.bottom).offset(18)
            make.height.equalTo(60)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(container)
            make.top.equalTo(confirmInput.snp.bottom).offset(6)
        }
    }
}



//import UIKit
//
//class UpdatePasswordViewController: FlowBaseViewController {
//
//    weak var titleLabel: UILabel!
//    weak var titleDetailLabel: UILabel!
//    weak var errorLabel: UILabel!
//    weak var passwordInput: TYInput!
//    weak var confirmInput: TYInput!
//    weak var container: UILayoutGuide!
//
//    var verificationCode: String!
//    var phoneNumber: String!
//
//    lazy var HUD: SimpleHUD = {
//        let HUD = SimpleHUD(labelString: "One Moment...")
//        HUD.alpha = 0
//        return HUD
//    }()
//
//    init(phoneNumber: String, verificationCode: String) {
//        super.init(nibName: nil, bundle: nil)
//        self.verificationCode = verificationCode
//        self.phoneNumber = phoneNumber
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        viewsSetup()
//        viewsLayout()
//        setup()
//    }
//
//    private func viewsSetup() {
//        let titleLabel = SpacingLabel(text: "New password", font: UIFont.avenirNext(bold: .medium, size: 24))
//        titleLabel.textAlignment = .center
//        self.titleLabel = titleLabel
//        view.addSubview(titleLabel)
//
//        let titleDetailLabel = SpacingLabel(text: "Your password should be at least 8 characters", font: UIFont.avenirNext(bold: .regular, size: 14))
//        titleDetailLabel.updateColor(to: TYInput.defaultLabelColor)
//        titleDetailLabel.textAlignment = .center
//        titleDetailLabel.numberOfLines = 0
//        self.titleDetailLabel = titleDetailLabel
//        view.addSubview(titleDetailLabel)
//
//        let passwordInput = TYInput(frame: CGRect.zero, label: "NEW PASSWORD", type: .password, defaultSecure: true)
//        self.passwordInput = passwordInput
//        view.addSubview(passwordInput)
//
//        let confirmInput = TYInput(frame: CGRect.zero, label: "CONFIRM PASSWORD", type: .password, defaultSecure: true)
//        self.confirmInput = confirmInput
//        view.addSubview(confirmInput)
//
//        let errorLabel = SpacingLabel(text: "", spacing: 0.5, font: UIFont.avenirNext(bold: .regular, size: 12))
//        errorLabel.numberOfLines = 0
//        errorLabel.updateColor(to: .red)
//        self.errorLabel = errorLabel
//        view.addSubview(errorLabel)
//
//        let container = UILayoutGuide()
//        self.container = container
//        view.addLayoutGuide(container)
//    }
//
//    private func viewsLayout() {
//        titleLabel.snp.makeConstraints { (make) in
//            make.top.left.right.equalTo(container)
//        }
//
//        titleDetailLabel.snp.makeConstraints { (make) in
//            make.left.right.equalTo(container)
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//        }
//
//        passwordInput.snp.makeConstraints { (make) in
//            make.left.right.equalTo(container)
//            make.top.equalTo(titleDetailLabel.snp.bottom).offset(36)
//        }
//
//        confirmInput.snp.makeConstraints { (make) in
//            make.left.right.equalTo(container)
//            make.top.equalTo(passwordInput.snp.bottom).offset(18)
//        }
//
//        errorLabel.snp.makeConstraints { (make) in
//            make.left.right.equalTo(container)
//            make.top.equalTo(confirmInput.snp.bottom).offset(6)
//        }
//
//        container.snp.makeConstraints { (make) in
//            make.centerX.bottom.equalToSuperview()
//            make.top.equalToSuperview().offset(80)
//            make.left.equalToSuperview().offset(60)
//        }
//    }
//
//    private func setup() {
//        passwordInput.delegate = self
//        confirmInput.delegate = self
//        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//    }
//
//    private func checkInputValid() {
//        inputValid = passwordInput.text.count > 7 && confirmInput.text.count > 7
//    }
//
//    private func allowInput(_ string: String) -> Bool {
//        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "!@#$%^&*()~`?"))
//        return string.unicodeScalars.allSatisfy { allowedCharacterSet.contains($0) }
//    }
//
//    private func checkPassword(completion: (Bool, String?) -> Void) {
//        let newPassword = passwordInput.text
//        let confirm = confirmInput.text
//
//        guard newPassword .count > 7 else {
//            completion(false, "Password shoud be at least 8 characters")
//            return
//        }
//
//        guard newPassword == confirm else {
//            completion(false, "Confirm password is not matched")
//            return
//        }
//
//        completion(true, nil)
//    }
//
//    private func showError(_ error: String?) {
//        errorLabel.text = error
//    }
//
//    private func hideError() {
//        errorLabel.text = ""
//    }
//
//    private func showHUD() {
//        view.addSubview(HUD)
//        UIView.animate(withDuration: 0.15) {
//            self.HUD.alpha = 1
//        }
//    }
//
//    private func hideHUD() {
//        UIView.animate(withDuration: 0.15, animations: {
//            self.HUD.alpha = 0
//        }) { (_) in
//            self.HUD.removeFromSuperview()
//        }
//    }
//
//    private func updatePassword(_ password: String) {
//        displayHUD()
//        APIService.shared.resetPassword(phoneNumber: phoneNumber, verificationCode: verificationCode, password: password) { (success) in
//            self.removeHUD()
//
//            if success {
//                let finish = FinishViewController(forgotFlow: true)
//                self.navigationController?.pushViewController(finish, animated: false)
//            } else {
//                self.showError("Reset password failed.")
//            }
//        }
//    }
//
//    @objc func nextButtonTapped() {
//        let password = passwordInput.text
//        checkPassword() { (correct, message) in
//            if correct {
//                updatePassword(password)
//            } else {
//                self.showError(message)
//            }
//        }
//    }
//
//    override func backButtonTapped() {
//        if let vcs = navigationController?.viewControllers, vcs.count > 1 {
//            let landingVC = vcs[1]
//            navigationController?.popToViewController(landingVC, animated: true)
//        }
//    }
//}
//
//extension UpdatePasswordViewController: TYInputDelegate {
//    func input(_ input: TYInput, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let isAllowed = allowInput(string)
//        if !isAllowed {
//            input.blink()
//        }
//        return isAllowed
//    }
//
//    func input(_ input: TYInput, valueChangeTo string: String?) {
//        hideError()
//        checkInputValid()
//    }
//}
//
