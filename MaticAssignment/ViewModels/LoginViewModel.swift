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
        if let data = acctManager.retrieveAccountFromKeyChain(passOrHash: "pass") {
            print("Retrieved account user : \(data)")
            return true
        }
        
        return true
    }
    
    func createAccountWith(Username user:String, password: String) -> Bool {
        // Create credentials
        // Set the credentials to account manager
        // account manager will store
        let credentials = Credentials(username: user, password: password)
        let acctManager = AccountManager.shared
        acctManager.credentials = credentials
        
        if let encryptedPass = acctManager.encryptPasswordWithHash() {
            acctManager.storeUserAndEncryptedPassInKeychain(encryptedPass: encryptedPass)
            acctManager.storeUserAndRandomHashInKeychain()
        }
        return true
    }
    
}
