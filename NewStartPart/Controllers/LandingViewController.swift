//
//  LandingViewController.swift
//  StartPart
//
//  Created by Yi Tong on 6/28/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit
import SnapKit

class LandingViewController: StartBaseViewController {
    weak var logInButton: UIButton!
    weak var signUpButton: UIButton!
    weak var logoImageView: UIImageView!
    weak var topArea: UILayoutGuide!
    weak var bottomArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //Objc functions
    @objc func logInButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func signUpButtonTapped() {
        navigationController?.pushViewController(NameViewController(), animated: false)
    }
    
    override func backButtonTapped(sender: UIButton) {
        navigationController?.pushViewControllerFromLeft(PortalViewController(), animated: true)
    }
}

extension LandingViewController { //Helper functions
    private func setup() {
        nextButton.isHidden = true
        view.backgroundColor = .white
        
        let topArea = UILayoutGuide()
        self.topArea = topArea
        view.addLayoutGuide(topArea)
        
        let bottomArea = UILayoutGuide()
        self.bottomArea = bottomArea
        view.addLayoutGuide(bottomArea)
        
        let logInButton = UIButton(type: .system)
        let attributedTitle1 = NSAttributedString(string: "LOG IN", attributes: [NSAttributedString.Key.kern: 1, NSAttributedString.Key.font: UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize), NSAttributedString.Key.foregroundColor: UIColor.white])
        logInButton.setAttributedTitle(attributedTitle1, for: .normal)
        logInButton.backgroundColor = UIColor(r: 247, g: 163, b: 32)
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        self.logInButton = logInButton
        view.addSubview(logInButton)
        
        let signUpButton = UIButton(type: .system)
        let attributedTitle2 = NSAttributedString(string: "SIGN UP", attributes: [NSAttributedString.Key.kern: 1, NSAttributedString.Key.font: UIFont.avenirNext(bold: .medium, size: UIFont.largeFontSize), NSAttributedString.Key.foregroundColor: UIColor.white])
        signUpButton.setAttributedTitle(attributedTitle2, for: .normal)
        signUpButton.backgroundColor = UIColor(r: 59, g: 143, b: 206)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        self.signUpButton = signUpButton
        view.addSubview(signUpButton)
        
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        self.logoImageView = logoImageView
        view.addSubview(logoImageView)
        
        bottomArea.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(160)
        }
        
        topArea.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(bottomArea.snp.top)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.center.equalTo(topArea)
            make.width.equalTo(140)
            make.height.equalTo(logoImageView.snp.width)
        }
        
        logInButton.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bottomArea)
            make.height.equalTo(bottomArea).multipliedBy(0.5)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(bottomArea)
            make.height.equalTo(bottomArea).multipliedBy(0.5)
        }
    }
}
