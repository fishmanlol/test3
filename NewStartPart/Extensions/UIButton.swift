//
//  UIButton.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/17/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

extension UIButton {
    
    func roundCorner(with radius: CGFloat? = nil) {
        if let radius = radius {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = bounds.height * 0.5
        }
        
        self.layer.masksToBounds = true
    }
}
