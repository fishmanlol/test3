//
//  SafariManager.swift
//  AiTmedPortal
//
//  Created by tongyi on 6/16/19.
//  Copyright © 2019 tongyi. All rights reserved.
//

import Foundation
import Alamofire

class Portal {
    
    enum Status {
        case notYet, success, failed(error: String), local
    }
    
    enum Role {
        case provider, patient
    }
    
    let SAFARI_NOT_EXIST = 0
    let SAFARI_TRUE = 1
    let SAFARI_FALSE = 2
    
    var status: Status = .notYet {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.init(rawValue: "portalStatusChanged"), object: nil, userInfo: ["role": role, "oldStatus": oldValue, "newStatus": status])
        }
    }
    
    
    var configUrl: String!
    var openSafariKey: String! //1: open, 2:not open, 0: not exist
    var safariUrlKey: String!
    var defaultUrl: URL!
    var url: URL!
    let role: Role
    
    init(role: Role) {
        self.role = role
        setup(for: role)
    }
    
    private func setup(for role: Role) {
        switch role {
        case .patient:
            self.configUrl = "https://aitmed.com/appconf/ios_patient.conf"
            self.openSafariKey = "patientOpenSafariKey"
            self.safariUrlKey = "patientSafariUrlKey"
            self.defaultUrl = URL(string: "https://aitmed.com")!
            self.url = defaultUrl
        case .provider:
            self.configUrl = "https://aitmed.com/appconf/ios_provider.conf"
            self.openSafariKey = "providerOpenSafariKey"
            self.safariUrlKey = "providerSafariUrlKey"
            self.defaultUrl = URL(string: "https://aitmed.com/signin/provider")!
            self.url = defaultUrl
        }
        
        updateStatus(for: role)
    }
    
    private func updateStatus(for role: Role) {
            let config = URL(string: configUrl)!
            Alamofire.request(config).responseJSON { (response) in
                if let error = response.error {
                    print(error.localizedDescription)
                    self.status = .failed(error: error.localizedDescription)
                    self.url = self.defaultUrl
                    return
                }

                if let data = response.data, let config = try? JSONDecoder().decode(Config.self, from: data) {
                   //Do next
                    print("---------------------retreive conf: \(config.webportal)")
                    if config.safari {
                        self.url = URL(string: config.webportal) ?? self.defaultUrl
                        self.status = .success
                        print("---------------------success! open safari: \(self.url.absoluteString)")
                    } else {
                        self.status = .local
                        print("---------------------local")
                    }
                    
                } else {
                    self.url = self.defaultUrl
                    self.status = .failed(error: "---------------------json decode error")
                    print("---------------------error! open safari: \(self.url.absoluteString)")
                }
            }
        }
    
    struct Config: Decodable {
        let webportal: String
        let safari: Bool
        
//        enum Codingkeys: String, CodingKey {
//            case openSafari = "safari"
//            case webportal
//        }
    }
}


class SafariManager {
    
//    let patient = Portal(role: .patient)
    let provider = Portal(role: .provider)
    
    static let shared = SafariManager()
    private init() {}
    
    
}
