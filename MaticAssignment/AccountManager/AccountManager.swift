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
    
    func storeUserAndEncryptedPassInKeychain(encryptedPass: Data) {
        guard let creds = credentials else {
            return
        }
        let account = creds.username
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrLabel as String: "pass",
                                    kSecValueData as String: encryptedPass]
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func storeUserAndRandomHashInKeychain() {
        guard let creds = credentials,
              let hash = randomHash
        else {
            print("Missing credentials or hash")
            return
        }
        let account = creds.username
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrLabel as String: "hash",
                                    kSecValueData as String: hash]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func retrieveAccountFromKeyChain(passOrHash: String) -> Data? {
        guard let creds = credentials else {
            return nil
        }
        let account = creds.username
        let query: [String: Any] = [kSecClass as String: kSecClassIdentity,
                                    kSecAttrAccount as String: account,
                                    kSecAttrLabel as String: passOrHash]
        var secureItemValue: AnyObject?
        let statusCode: OSStatus = SecItemCopyMatching(query as CFDictionary, &secureItemValue)
        if statusCode == noErr {
            return secureItemValue as? Data
        }
        else {
            print(statusCode)
            return nil
        }
    }
}

extension Data {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
