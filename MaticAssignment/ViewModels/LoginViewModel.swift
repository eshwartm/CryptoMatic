//
//  LoginViewModel.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation

class LoginViewModel {
    func retrieveAccountWithUser(user: String, password: String) -> Bool {
        let credentials = Credentials(username: user, password: password)
        let acctManager = AccountManager.shared
        acctManager.credentials = credentials
        if let dict = acctManager.retrieveAccountFromKeyChain(passOrHash: "pass") {
            print("Retrieved account user : \(dict)")
            return true
        }
        
        return false
    }
    
    func createAccountWith(Username user:String, password: String) -> Bool {
        // Create credentials
        // Set the credentials to account manager
        // account manager will store
        let credentials = Credentials(username: user, password: password)
        let acctManager = AccountManager.shared
        acctManager.credentials = credentials
        
        if let encryptedPass = acctManager.encryptPasswordWithHash() {
            acctManager.storeUserAndRandomHashAndPassInKeychain(encryptedPassword: encryptedPass)
        }
        return true
    }
    
}
