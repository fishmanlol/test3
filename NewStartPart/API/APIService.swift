////
////  APIService.swift
////  StartPart
////
////  Created by Yi Tong on 7/8/19.
////  Copyright © 2019 Yi Tong. All rights reserved.
////
//
import Foundation
import Alamofire

class APIService {
    static let baseURLString = "https://api.aitmed.com/"
    
    //login
    static let loginWithPasswordURLString = "v2beta1/account/patient/login/"
    static let loginWithVerificationCodeURLString = "v2beta1/account/patient/login/?method=sms_verify"
    //send verification code
    static let sendVerificationCodeURLString = "v2beta1/sms/send_verification_code/"
    //registration
    static let registerURLString = "v2beta1/account/patient/"
    //reset password
    static var resetPasswordURLString: String {
        let userId = UserDefaults.standard.string(forKey: UserDefaults.USERIDKey) ?? ""
        return "v2beta1/account/patient/\(userId)/password/"
    }
    //check user exist
    static let userExistsURLString = "v2beta1/account/patient/exists_phone_number/"
    
    static let shared: APIService = APIService()
    
    private init() {}
    
    func login(phoneNumber: String, password: String, completion: @escaping (Bool, ErrorDetail?, RegistrationAndLoginResultData?) -> Void) {
        let urlString = APIService.baseURLString + APIService.loginWithPasswordURLString
        let parameters = ["phone_number": phoneNumber, "password": password]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if let error = response.error {
                completion(false, ErrorDetail.general, nil)
                print("login with password error: \(error)")
                return
            }
            
            if let dict = response.value as? [String: Any], let result = AiTmedResult<RegistrationAndLoginResultData>(dict: dict) {
                if result.errorCode == "0" {
                    guard let userId = result.data?.userId, let jwt = result.data?.jwtToken, let tvToken = result.data?.tvToken, let tvId = result.data?.tvId else {
                        completion(false, ErrorDetail.general, nil)
                        return
                    }
                    self.saveIntoUserDefaults(userId: userId, jwt: jwt, tvToken: tvToken, tvId: tvId)
                    completion(true, nil, result.data)
                } else {
                    print("login with password errorr: ", result.errorDetails)
                    if let errorDetail = result.errorDetails?.first {
                        completion(false, errorDetail, nil)
                    } else {
                        completion(false, ErrorDetail.general, nil)
                    }
                }
                
            } else {
                print("login with password parse error: ", response.value as? [String: Any])
                completion(false, ErrorDetail.general, nil)
            }
        }
    }
    
    private func saveIntoUserDefaults(userId: String, jwt: String, tvToken: String, tvId: String) {
        UserDefaults.standard.set(userId, forKey: UserDefaults.USERIDKey)
        UserDefaults.standard.set(jwt, forKey: UserDefaults.JWTKey)
        UserDefaults.standard.set(tvToken, forKey: UserDefaults.TVTKey)
        UserDefaults.standard.set(tvId, forKey: UserDefaults.TVIDKey)
    }
        
}
    


//    
//    func login(phoneNumber: String, verificationCode: String, completion: @escaping (Bool, RegistrationAndLoginResultData?) -> Void) {
//        let urlString = APIService.baseURLString + APIService.loginWithVerificationCodeURLString
//        let parameters = ["phone_number": phoneNumber, "phone_verification_code": verificationCode]
//        
//        print("-------------")
//        print(parameters)
//        print(urlString)
//        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if let error = response.error {
//                print("login with verification code error: ", error)
//                completion(false, nil)
//                return
//            }
//            
//            if let dict = response.value as? [String: Any], let result = AiTmedResult<RegistrationAndLoginResultData>(dict: dict) {
//                if result.errorCode == "0" {
//                    guard let userId = result.data?.userId, let jwt = result.data?.jwtToken, let tvToken = result.data?.tvToken, let tvId = result.data?.tvId else {
//                        completion(false, nil)
//                        return
//                    }
//                    print("login with verification code success")
//                    self.saveIntoUserDefaults(userId: userId, jwt: jwt, tvToken: tvToken, tvId: tvId)
//                    completion(true, result.data)
//                } else {
//                    print("login with verification code errorr: ", result.errorDetails)
//                    completion(false, nil)
//                }
//                
//            } else {
//                print("login with verification code parse error: ", response.value as? [String: Any])
//                completion(false, nil)
//            }
//        }
//    }
//    
//    func sendVerficationCode(phoneNumber: String, completion: @escaping (Bool) -> Void) {
//        let urlString = APIService.baseURLString + APIService.sendVerificationCodeURLString
//        let parameters: [String: String] = ["phone_number": phoneNumber]
//        
//        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if let error = response.error {
//                print("send vrfication code error: ", error)
//                completion(false)
//                return
//            }
//            
//            if let dict = response.value as? [String: Any], let result = AiTmedResult<VerificationResultData>(dict: dict) {
//                if result.errorCode == "0" {
//                    print("send verification code success")
//                    completion(true)
//                } else {
//                    print("send verification code error", result.errorDetails)
//                    completion(false)
//                }
//            } else {
//                print("send verification code parse error: ", response.value as? [String: Any])
//                completion(false)
//            }
//            
//        }
//    }
//    
//    func validVerificationCode(phoneNumber: String, verificationCode: String, completion: (Bool) -> Void) {
//        
//    }
//    
//    func register(phoneNumber: String, verificationCode: String, password: String, firstName: String, middleName: String?, lastName: String?, completion: @escaping (Bool, RegistrationAndLoginResultData?) -> Void) {
//        let urlString = APIService.baseURLString + APIService.registerURLString
//        let parameters: [String: Any] = ["phone_number": phoneNumber,
//                                            "phone_verification_code": verificationCode,
//                                            "password": password,
//                                            "first_name": firstName,
//                                            "middle_name": middleName ?? "",
//                                            "last_name": lastName ?? "",
//                                            "force_delete": true]
//
//        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if let error = response.error {
//                print("register error: ", error)
//                completion(false, nil)
//                return
//            }
//            
//            if let dict = response.value as? [String: Any], let result = AiTmedResult<RegistrationAndLoginResultData>(dict: dict) {
//                if result.errorCode == "0" {
//                    guard let userId = result.data?.userId, let jwt = result.data?.jwtToken, let tvToken = result.data?.tvToken, let tvId = result.data?.tvId else {
//                        completion(false, nil)
//                        return
//                    }
//                    print("register success")
//                    self.saveIntoUserDefaults(userId: userId, jwt: jwt, tvToken: tvToken, tvId: tvId)
//                    completion(true, result.data)
//                } else {
//                    print("register error: ", result.errorDetails)
//                    completion(false, nil)
//                }
//                
//            } else {
//                print("register parse error: ", response.value as? [String: Any])
//                completion(false, nil)
//            }
//        }
//    }
//    
//    func resetPassword(phoneNumber: String, verificationCode: String, password: String, completion: @escaping (Bool) -> Void) {
//        let urlString = APIService.baseURLString + APIService.resetPasswordURLString
//        let parameters = ["phone_number": phoneNumber,
//                          "phone_verification_code": verificationCode,
//                          "password": password]
//        let jwt = "JWT \(UserDefaults.standard.string(forKey: UserDefaults.JWTKey) ?? "")"
//        Alamofire.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: ["Authorization": jwt]).responseString { (response) in
//            
//            switch response.result {
//            case .success(_):
//                print("reset password success")
//                completion(true)
//            case .failure(let error):
//                print("reset password error: ", error)
//                completion(false)
//            }
//        }
//    }
//    
//    func isPhoneNumberExists(phoneNumber: String, completion: @escaping (Error?, UserExistsResultData?) -> Void) {
//        let urlStirng = APIService.baseURLString + APIService.userExistsURLString
//        let parameters = ["phone_number": phoneNumber]
//        
//        Alamofire.request(urlStirng, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            if let error = response.error {
//                print("Check user exists error: ", error)
//                completion(error, nil)
//                return
//            }
//            
//            if let dict = response.value as? [String: Any], let result = AiTmedResult<UserExistsResultData>(dict: dict) {
//                if result.errorCode == "0" {
//                    print("Check user exists success")
//                    completion(nil, result.data)
//                } else {
//                    print("Check user exists error: ", result.errorDetails)
//                    completion(nil, nil)
//                }
//                
//            } else {
//                print("Check user exists parse error: ", response.value as? [String: Any])
//                completion(nil, nil)
//            }
//        }
//    }
//    

//}
//
