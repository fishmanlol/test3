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
    
    private static let shared = HUD()
    private var showDate: Date?
    
    static func show(_ title: String) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        shared.alpha = 0
        shared.frame = UIScreen.main.bounds
        shared.label.text = title
        keyWindow.addSubview(HUD.shared)
        UIView.animate(withDuration: 0.15, animations: {
            shared.alpha = 1
        }) { (_) in
            shared.showDate = Date()
        }
    }
    
    static func hide(min seconds: TimeInterval = 0) {
        let s = seconds < 0 ? 0 : seconds
        
        if s == 0 {//hide immediately
            UIView.animate(withDuration: 0.15, animations: {
                HUD.shared.alpha = 0
            }) { (_) in
                HUD.shared.removeFromSuperview()
            }
        } else {
            
            
            Timer.scheduledTimer(withTimeInterval: s, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.15, animations: {
                    HUD.shared.alpha = 0
                }) { (_) in
                    HUD.shared.removeFromSuperview()
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
    
    private func setup() {
        let label = TYLabel(frame: CGRect.zero)
        label.font = UIFont.avenirNext(bold: .regular, size: UIFont.largeFontSize)
        self.label = label
        self.addSubview(label)
        
        let indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator.activityIndicatorViewStyle = .medium
        } else {
            indicator.activityIndicatorViewStyle = .gray
        }
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
        
        setupBlurEffect()
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
            backgroundColor = UIColor(white: 0.5, alpha: 0.7)
        }
    }
}
