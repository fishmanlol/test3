//
//  StartBaseViewController.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/16/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit
import SnapKit

class StartBaseViewController: UIViewController {
    weak var backButton: UIButton!
    weak var nextButton: UIButton!
    
    private  var defaultDistanceToBottom: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        popupKeyboardIfNeeded()
    }
    
    @objc func keyboardFrameChanged(notification: Notification) {
        if let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let curve = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            if !(rect.minY < UIScreen.main.bounds.maxY) { //keyboard will out of screen
                updateNextButtonPostion(distanceToBottom: defaultDistanceToBottom, curve: UInt(curve), duration: duration)
            } else { //keyboard will on screen
                let keyboardHeight = rect.height
                updateNextButtonPostion(distanceToBottom: keyboardHeight + 20) //curve: UInt(curve), duration: duration
            }
        }
    }
    
    @objc func backButtonTapped(sender: UIButton) {
        print("123")
    }
    
    private func updateNextButtonPostion(distanceToBottom: CGFloat, curve: UInt? = nil, duration: Double? = nil) {
        nextButton.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-distanceToBottom)
        }
        
        guard let curve = curve, let duration = duration else { return }
        
        UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func popupKeyboardIfNeeded() {
        for v in view.subviews {
            if v is TYInput {
                v.becomeFirstResponder()
                return
            }
        }
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanged), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.backButton = backButton
        view.addSubview(backButton)
        
        let nextButton = TYButton()
        nextButton.setTitle("Continue", for: .normal)
        self.nextButton = nextButton
        view.addSubview(nextButton)
        
        backButton.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(18)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            } else {
                make.left.equalToSuperview().offset(18)
                make.top.equalToSuperview().offset(12)
            }
            make.height.width.equalTo(26)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-defaultDistanceToBottom)
        }
    }
}
