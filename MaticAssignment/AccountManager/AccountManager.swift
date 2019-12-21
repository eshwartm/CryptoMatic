//
//  AccountManager.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import CryptoSwift

class AccountManager {
    
    static let shared = AccountManager()
    var credentials: Credentials?
    var randomHash: Data?
    
    func encryptPasswordWithHash() -> Data? {
        guard let creds = credentials else {
            return nil
        }
        do {
            let sourceData = "AES256".data(using: .utf8)!
            let password = creds.password
            let salt = AES256Crypter.randomSalt()
            randomHash = salt
            let iv = AES256Crypter.randomIv()
            let key = try AES256Crypter.createKey(password: password.data(using: .utf8)!, salt: salt)
            let aes = try AES256Crypter(key: key, iv: iv)
            let encryptedData = try aes.encrypt(sourceData)
            let decryptedData = try aes.decrypt(encryptedData)
            
            print("Encrypted hex string: \(encryptedData.hexString)")
            print("Decrypted hex string: \(decryptedData.hexString)")
            
            return encryptedData
        } catch {
            print("Failed")
            print(error)
            return nil
        }
    }
    
    func storeUserAndRandomHashAndPassInKeychain(encryptedPassword: Data?) {
        guard let creds = credentials,
              let encryptedPass = encryptedPassword,
              let hash = randomHash
        else {
            print("Missing credentials or hash")
            return
        }
        let account = creds.username
        let dict = [
            "pass": encryptedPass.hexString,
            "hash": hash.hexString
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject:dict) {
            KeychainWrapper.standard.set(jsonData, forKey: account)
        }
    }
    
    func retrieveAccountFromKeyChain() -> [String: Any]? {
        guard let creds = credentials else {
            return nil
        }
        let account = creds.username
        if let data = KeychainWrapper.standard.data(forKey: account) {
            if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? [String:Any] {
                print("Fetched data from keychain : \(jsonDict)")
                return jsonDict
            }
            return nil
        }
        return nil
    }
}

extension Data {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
