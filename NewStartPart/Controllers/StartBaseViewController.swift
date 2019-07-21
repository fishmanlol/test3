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
    weak var nextButton: TYButton!
    
    private  var defaultDistanceToBottom: CGFloat = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateNextButtonPostion(distanceToBottom: defaultDistanceToBottom)
        popupKeyboardIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    func startLoading() {
        //1.Disable next button
        //32 Animate nextbutton
        nextButton.isEnabled = false
        nextButton.startAnimating()
    }
    
    func stopLoading() {
        //1. Stop animating nextbutton
        //2. Enable next button
        nextButton.stopAnimating()
        nextButton.isEnabled = true
    }
    
    @objc func keyboardFrameWillChange(notification: Notification) {
        if let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let _ = (notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let _ = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            if !(rect.minY < UIScreen.main.bounds.maxY) { //keyboard will out of screen
                updateNextButtonPostion(distanceToBottom: defaultDistanceToBottom)
            } else { //keyboard will on screen
                updateNextButtonPostion(distanceToBottom: rect.height + 20) //curve: UInt(curve), duration: duration
            }
        }
    }
    
    @objc func backButtonTapped(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped(sender: TYButton) {}
    
    private func updateNextButtonPostion(distanceToBottom: CGFloat, curve: UInt? = nil, duration: Double? = nil) {
        let w: CGFloat = 220
        let h: CGFloat = 40
        
        if let curve = curve, let duration = duration {
            UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
                self.nextButton.frame = CGRect(x: 0.5 * (self.view.width - w), y: self.view.height - distanceToBottom - h, width: w, height: h)
            }, completion: nil)
        } else {
            UIView.setAnimationsEnabled(false)
            nextButton.frame = CGRect(x: 0.5 * (view.width - w), y: view.height - distanceToBottom - h, width: w, height: h)
            UIView.setAnimationsEnabled(true)
        }
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "arrow_back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.backButton = backButton
        view.addSubview(backButton)
        
        let nextButton = TYButton()
        nextButton.setTitle("Continue", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.isEnabled = false
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
    }
}
