//
//  Validator.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/16/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation

class Validator {
    //Can not be empty, and cannot be empty after trimmed
    static func validName(_ name: String) -> Bool {
        guard name.count != 0 else { return false }
        return true
    }
    
    //At least 8 characters
    static func validPassword(_ password: String) -> Bool {
        guard password.count > 7 else { return false }
        return true
    }
}
