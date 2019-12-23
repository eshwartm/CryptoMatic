//
//  LoginViewModel.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    var mode: String?
    
    init(mode: String? = nil) {
        self.mode = mode
    }
    
    func retrieveAccountManager(credentials: Credentials) -> AccountManager {
        let acctManager = AccountManager(credentials: credentials)
        return acctManager
    }
    
    func retrieveAccountWithUser(credentials: Credentials) -> Bool {
        let acctManager = retrieveAccountManager(credentials: credentials)
        if let dict = acctManager.retrieveAccountFromKeyChain() {
            print("Retrieved account user : \(dict)")
            return true
        }
        return false
    }
    
    func createAccountWith(credentials: Credentials) -> Bool {
        // Create credentials
        // Set the credentials to account manager
        // account manager will store
        let acctManager = retrieveAccountManager(credentials: credentials)
        if let encryptedPass = acctManager.encryptPasswordWithHash() {
            acctManager.storeUserAndRandomHashAndPassInKeychain(encryptedPassword: encryptedPass)
        }
        return true
    }
    
}
