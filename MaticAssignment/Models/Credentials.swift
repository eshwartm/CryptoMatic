//
//  Credentials.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/21/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

struct Credentials {
    var username: String
    var password: String
    
    init(user: String, pass: String) {
        self.username = user
        self.password = pass
    }
    
    func retrieveSalt() -> String {
        let user = self.username
        if let data = KeychainWrapper.standard.data(forKey: user) {
            if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? [String:Any] {
                print("Fetched data from keychain : \(jsonDict)")
                if let salt = jsonDict["hash"] as? String {
                    return salt
                }
            }
        }
        return ""
    }
}
