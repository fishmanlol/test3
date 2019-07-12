//
//  UIFont.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/9/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import UIKit

extension UIFont {
    static func avenirNext(bold: Bold, size: CGFloat) -> UIFont {
        switch bold {
        case .medium:
            return UIFont(name: "AvenirNext-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case .regular:
            return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    enum Bold {
        case regular, medium
    }
    
    static func menlo(bold: Bold, size: CGFloat) -> UIFont {
        switch bold {
        case .medium:
            return UIFont(name: "Menlo-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case .regular:
            return UIFont(name: "Menlo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
