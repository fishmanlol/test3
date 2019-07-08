//
//  TextAreaView.swift
//  NewStartPart
//
//  Created by tongyi on 7/8/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation
import UIKit

protocol TextAreaView: class {
    var text: String {get set}
    var textColor: UIColor {get set}
    var textFont: UIFont {get set}
    var kern: CGFloat {get set}
}

extension TextAreaView where Self: UIView {
    
}
