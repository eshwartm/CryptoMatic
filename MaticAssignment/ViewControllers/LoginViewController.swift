//
//  LoginViewController.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    class func get() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
