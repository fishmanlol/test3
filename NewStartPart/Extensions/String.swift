//
//  String.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/9/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var onlyNumber: String {
        return self.filter { $0.isNumber }
    }
    
    func size(with font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func width(with font: UIFont) -> CGFloat {
        return size(with: font).width
    }
    
    func height(with font: UIFont) -> CGFloat {
        return size(with: font).height
    }
}
