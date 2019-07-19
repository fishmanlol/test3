//
//  UserDefaults.swift
//  NewStartPart
//
//  Created by Yi Tong on 7/17/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation

extension UserDefaults {
    static let USERIDKey = "USERID"
    static let JWTKey = "JWT"
    static let TVTKey = "TVT"
    static let TVIDKey = "TVID"
    
    static func save(userId: String, jwt: String, tvToken: String, tvId: String) {
        UserDefaults.standard.set(userId, forKey: UserDefaults.USERIDKey)
        UserDefaults.standard.set(jwt, forKey: UserDefaults.JWTKey)
        UserDefaults.standard.set(tvToken, forKey: UserDefaults.TVTKey)
        UserDefaults.standard.set(tvId, forKey: UserDefaults.TVIDKey)
    }
}
