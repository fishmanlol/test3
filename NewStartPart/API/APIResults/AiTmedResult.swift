//
//  AiTmedResult.swift
//  StartPart
//
//  Created by Yi Tong on 7/8/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation

protocol ResultData {
    init?(dict: [String: Any])
}

struct ErrorDetail {
    static let generalErrorMessage = "Error happens, please try again later."
    static let general = ErrorDetail(message: ErrorDetail.generalErrorMessage)
    
    var errorName: String = ""
    var errorMessage: String = ""
    
    init(errorPair: (String, String)) {
        let (errorName, errorMessage) = errorPair
        
        self.errorName = errorName
        self.errorMessage = formatted(errorMessage)
    }
    
    init(message: String) {
        let pair = ("", message)
        self.init(errorPair: pair)
    }
    
    private func formatted(_ message: String) -> String {
        //password is not correct
        if message.hasPrefix("cannot login to truevault {'code': 'AUTH.UNSUCCESSFUL'") {
            return "password is not correct."
        }
        
        return message
    }
}

class AiTmedResult<T: ResultData> {
    let errorCode: String
    var errorDetails: [ErrorDetail]?
    var data: T?
    var pagination: Int?
    
    init?(dict: [String: Any]) {
        guard let errorCode = dict["error_code"] as? Int else { return nil }
        self.errorCode = "\(errorCode)"
        
        if let errorDetailsDict = dict["error_detail"] as? [String: String] {
            self.errorDetails = []
            for singleErrorDetail in errorDetailsDict {
                let errorDetail = ErrorDetail(errorPair: singleErrorDetail)
                self.errorDetails?.append(errorDetail)
            }
        }
        
        if let rawDict = dict["data"] as? [String: Any], let data = T(dict: rawDict)  {
            self.data = data
        }
        
        if let pagination = dict["pagination"] as? Int {
            self.pagination = pagination
        }
    }
}

//Registraion Data
class RegistrationAndLoginResultData: ResultData {
    let userId: String
    let jwtToken: String
    let tvToken: String
    let tvId: String
    
    required init?(dict: [String: Any]) {
        guard let userId = dict["user_id"] as? String, let jwtToken = dict["jwt_token"] as? String, let tvToken = dict["tv_access_token"] as? String, let tvId = dict["tv_uid"] as? String else {
            return nil
        }
        
        self.userId = userId
        self.jwtToken = jwtToken
        self.tvToken = tvToken
        self.tvId = tvId
    }
}

//Verification Data
class VerificationResultData: ResultData {

    required init?(dict: [String: Any]) { return nil }
}

//Reset Password Data
class ResetPasswordResultData: ResultData {
    let userId: String
    let phoneNumber: String
    
    required init?(dict: [String : Any]) {
        guard let userId = dict["user_id"] as? String, let phoneNumber = dict["phone_number"] as? String else {
            return nil
        }
        
        self.userId = userId
        self.phoneNumber = phoneNumber
    }
}

//Check user exists
class UserExistsResultData: ResultData {
    let exists: Bool
    
    required init?(dict: [String : Any]) {
        guard let exists = dict["exists"] as? Bool else {
            return nil
        }
        
        self.exists = exists
    }
}
