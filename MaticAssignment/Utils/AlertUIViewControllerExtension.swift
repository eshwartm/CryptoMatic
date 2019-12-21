//
//  AlertUIViewControllerExtension.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/21/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
     func showAlertWithText(text: String) {
           let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
}
