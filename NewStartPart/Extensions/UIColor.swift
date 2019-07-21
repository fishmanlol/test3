//
//  UIColor.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/9/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let lightGray = UIColor(r: 207, g: 212, b: 217)
    static let drakGray = UIColor(r: 170, g: 175, b: 180)
    static let lightBlue = UIColor(r: 79, g: 170, b: 248)
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
}
