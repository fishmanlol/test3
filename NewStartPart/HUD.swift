//
//  HUD.swift
//  NewStartPart
//
//  Created by tongyi on 7/19/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

class HUD: UIView {
    weak var label: TYLabel!
    weak var activityIndicator: UIActivityIndicatorView!
    weak var container: UIStackView!
    
    private static let shared = HUD(frame: UIScreen.main.bounds)
    private var showDate: Date?
    private var animationDuration: Double = 0.15
    
    static func show(_ title: String, completion: @escaping () -> Void = {}) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        shared.label.text = title
        shared.showDate = Date()
        keyWindow.addSubview(HUD.shared)
        UIView.animate(withDuration: shared.animationDuration, animations: {
            shared.alpha = 1
            completion()
        })
    }
    
    static func hide(min seconds: TimeInterval = shared.animationDuration, completion: @escaping () -> Void = {}) {//hide HUD at least min seconds after
        guard let showDate = shared.showDate else { return }
        let min = seconds < shared.animationDuration ? shared.animationDuration : seconds
        let elapse = abs(showDate.timeIntervalSinceNow)
        
        if elapse - min >= 0 {//after min seconds, hide immediately
            UIView.animate(withDuration: shared.animationDuration, animations: {
                HUD.shared.alpha = 0
            }) { (_) in
                HUD.shared.removeFromSuperview()
                completion()
            }
        } else { //wait untill min seconds
            Timer.scheduledTimer(withTimeInterval: min - elapse, repeats: false) { (timer) in
                UIView.animate(withDuration: shared.animationDuration, animations: {
                    HUD.shared.alpha = 0
                }) { (_) in
                    HUD.shared.removeFromSuperview()
                    completion()
                }
            }
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension HUD {//Helper functions
    
    private func topWindow() -> UIWindow? {
        let frontToBackWindows = UIApplication.shared.windows.reversed()
        if let lastWindow = frontToBackWindows.last {
            return lastWindow
        }
        
        return nil
    }
    
    private func frontWindow() -> UIWindow? {
        let frontToBackWindows = UIApplication.shared.windows.reversed()
        for window in frontToBackWindows {
            let isWindownOnMainScreen = window.screen == UIScreen.main
            let isWindowVisible = !window.isHidden && window.alpha > 0
            let isWindowLevelSupport = window.windowLevel >= UIWindowLevelNormal
            let isKeyWindow = window.isKeyWindow
            
            if isWindownOnMainScreen && isWindowVisible && isWindowLevelSupport && isKeyWindow {
                return window
            }
        }
        
        return nil
    }
    
    private func setup() {
        let label = TYLabel(frame: CGRect.zero)
        label.font = UIFont.avenirNext(bold: .regular, size: UIFont.largeFontSize)
        self.label = label
        self.addSubview(label)
        
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.startAnimating()
        self.activityIndicator = indicator
        self.addSubview(indicator)
        
        let container = UIStackView(arrangedSubviews: [indicator, label])
        container.axis = .horizontal
        container.distribution = .fillProportionally
        container.spacing = 6
        self.container = container
        self.addSubview(container)
        
        container.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(40).priority(.high)
        }
        
        backgroundColor = UIColor(white: 1, alpha: 0.8)
//        setupBlurEffect()
    }
    
    private func setupBlurEffect() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            insertSubview(blurEffectView, at: 0)
        } else {
            backgroundColor = UIColor(white: 1, alpha: 0.8)
        }
    }
}
