//
//  HomeViewModel.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation

class HomeViewModel {
    var cryptos: BindingListener<[CryptoModel]?> = BindingListener(nil)
    var cryptosCount : Int {
        return self.cryptos.value?.count ?? 0
    }
    
    func cryptoItemAtIndex(index: Int) -> CryptoModel? {
        if self.cryptosCount > 0 {
            if let cryptosArr = self.cryptos.value {
                return cryptosArr[index]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func getAllCryptos() {
        if let filepath = Bundle.main.path(forResource: "crypto", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
                let tData = contents.data(using: .utf8)!
                self.cryptos.value = try! JSONDecoder().decode([CryptoModel].self, from: tData)
            } catch {
                // contents could not be loaded
                print("Could not decode data from json file \(error.localizedDescription)")
            }
        } else {
            print("Could not find file")
        }
    }
    
    func retrieveHash() -> String {
        let acctManager = AccountManager.shared
        if let dict = acctManager.retrieveAccountFromKeyChain() {
            print("Retrieved account user : \(dict)")
            if let hashStr = dict["hash"] as? String {
                return hashStr
            }
        }
        return ""
    }
}
