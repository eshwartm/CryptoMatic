//
//  CryptoViewModel.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/21/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation

class CryptoViewModel {
    private let crypto: CryptoModel!
    
    let name: String!
    let iconName: String!
    
    init(crypto: CryptoModel) {
        self.crypto = crypto
        
        name = self.crypto.name
        iconName = self.crypto.symbol.lowercased()
    }
    
    
}
