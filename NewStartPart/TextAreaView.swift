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
    var _text: String {get set}
    var _textColor: UIColor {get set}
    var _textFont: UIFont {get set}
    var _kern: CGFloat {get set}
}
