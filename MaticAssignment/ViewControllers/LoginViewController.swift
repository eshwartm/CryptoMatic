//
//  LoginViewController.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginOrSignUpButton: UIButton!
    
    var loginViewModel = LoginViewModel()
    
    class func get() -> LoginViewController {
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: LoginViewController.name) as! LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        passwordTextField.autocorrectionType = .no
    }
    
    @IBAction func loginOrSignUpButtonPressed(_ sender: UIButton) {
        guard let user = userNameTextField.text,
            let password = passwordTextField.text else {
                print("Username and password must be entered")
                return
        }
        var success = false
        if let buttonTitle = sender.titleLabel?.text {
            switch buttonTitle {
            case SIGN_IN:
                success = retrieveAccountAndLogin(user: user, pass: password)
            case CREATE_ACCOUNT:
                success = createAccountAndLogin(user: user, pass: password)
            default:
                success = false
            }
        }
        
        if success {
            let homeVC = HomeViewController.get()
            present(homeVC, animated: true, completion: nil)
        }
        else {
            self.showAlertWithText(text: "Something went wrong while trying to login")
        }
    }
    
    func retrieveAccountAndLogin(user: String, pass: String) -> Bool {
        return loginViewModel.retrieveAccountWithUser(user: user, password: pass)
    }
    
    func createAccountAndLogin(user: String, pass: String) -> Bool {
        if loginViewModel.retrieveAccountWithUser(user: user, password: pass) {
            return true
        }
        return loginViewModel.createAccountWith(Username: user, password: pass)
    }
}
