//
//  NSObjectExtension.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/21/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
