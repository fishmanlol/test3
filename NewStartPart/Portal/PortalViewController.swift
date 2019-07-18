//
//  PortalViewController.swift
//  AITMed
//
//  Created by Yi Tong on 6/17/19.
//  Copyright © 2019 Hieu Nguyen. All rights reserved.
//

import UIKit
import SnapKit

class PortalViewController: UIViewController {
    
    lazy var HUD: UIAlertController = {
       let alertController = UIAlertController(title: nil, message: "Waiting for server response...", preferredStyle: .alert)
        return alertController
    }()
    var observer: NSObjectProtocol?
    
    weak var providerButton: TYButton!
    weak var patientButton: TYButton!
    weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @objc func providerButtonTapped() {
        responseToStatus()
    }
    
    @objc func patientButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PortalViewController {
    private func setup() {
        let providerButton = TYButton(type: .system)
        providerButton.setTitle("I'M A PROVIDER", for: .normal)
        providerButton.backgroundColor = .white
        providerButton.setTitleColor(UIColor(r: 59, g: 143, b: 206), for: .normal)
        providerButton.titleFont = UIFont.avenirNext(bold: .medium, size: 15)
        providerButton.addTarget(self, action: #selector(providerButtonTapped), for: .touchUpInside)
        self.providerButton = providerButton
        view.addSubview(providerButton)
        
        let patientButton = TYButton(type: .system)
        patientButton.backgroundColor = UIColor(r: 59, g: 143, b: 206)
        patientButton.setTitle("I'M A PATIENT", for: .normal)
        patientButton.titleFont = UIFont.avenirNext(bold: .medium, size: 15)
        patientButton.addTarget(self, action: #selector(patientButtonTapped), for: .touchUpInside)
        self.patientButton = patientButton
        view.addSubview(patientButton)
        
        let imageView = UIImageView(image: UIImage(named: "portal_background"))
        imageView.contentMode = .scaleAspectFill
        self.backgroundImageView = imageView
        view.insertSubview(imageView, at: 0)
        
        providerButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(220)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        patientButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(220)
            make.bottom.equalTo(providerButton.snp.top).offset(-30)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func responseToStatus() {
        let provider = SafariManager.shared.provider
        switch provider.status {
        case .local:
            navigationController?.popViewController(animated: false)
        case .notYet:
            self.present(HUD, animated: true, completion: nil)
            removeObserver()
            addObserver()
        case .failed(let error):
            print(error)
            UIApplication.shared.open(provider.url, options: [:], completionHandler: nil)
        case .success:
            UIApplication.shared.open(provider.url, options: [:], completionHandler: nil)
        }
    }
    
    private func addObserver() {
        let provider = SafariManager.shared.provider
        switch provider.status {
        case .notYet:
            observer = NotificationCenter.default.addObserver(forName: Notification.Name.init(rawValue: "portalStatusChanged"), object: nil, queue: nil) { (notification) in
                self.dismiss(animated: true, completion: nil)
                if let status = notification.userInfo?["newStatus"] as? Portal.Status {
                    switch status {
                    case .failed(let error):
                        print("error: " + error)
                        UIApplication.shared.open(provider.url, options: [:], completionHandler: nil)
                    case .success:
                        print("success-----------------")
                        UIApplication.shared.open(provider.url, options: [:], completionHandler: nil)
                    default: break
                    }
                }
                
            }
        default: break
        }
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(observer as Any)
    }
}
