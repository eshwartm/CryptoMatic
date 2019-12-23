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
    
    var loginViewModel: LoginViewModel!
    
    class func get(mode: String) -> LoginViewController {
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: LoginViewController.name) as! LoginViewController
        loginVC.loginViewModel = LoginViewModel(mode: mode)
        return loginVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        passwordTextField.autocorrectionType = .no
        
        switch loginViewModel.mode {
        case SIGN_IN:
            self.titleLabel.text = SIGN_IN
            self.loginOrSignUpButton.setTitle(SIGN_IN, for: .normal)
        case CREATE_ACCOUNT:
            self.titleLabel.text = CREATE_ACCOUNT
            self.loginOrSignUpButton.setTitle(CREATE_ACCOUNT, for: .normal)
        default:
            self.titleLabel.text = SIGN_IN
            self.loginOrSignUpButton.setTitle(SIGN_IN, for: .normal)
        }
    }
    
    @IBAction func loginOrSignUpButtonPressed(_ sender: UIButton) {
        guard let user = userNameTextField.text,
              user.count > 0,
              let password = passwordTextField.text,
              password.count > 0
        else
        {
            self.showAlertWithTitleAndText(title: "Error", text: "Username and password must be entered.")
            return
        }
        var success = false
        let creds = Credentials(user: user, pass: password)
        switch loginViewModel.mode {
        case SIGN_IN:
            success = retrieveAccountAndLogin(credentials: creds)
        case CREATE_ACCOUNT:
            success = createAccountAndLogin(credentials: creds)
        default:
            success = false
        }
        
        
        if success {
            let homeVC = HomeViewController.get(credentials: creds)
            homeVC.isModalInPresentation = true
            present(homeVC, animated: true, completion: nil)
        }
        else {
            self.showAlertWithTitleAndText(title: "Error", text: "Could not fetch account: \(user). Please sign up.")
        }
    }
    
    func retrieveAccountAndLogin(credentials: Credentials) -> Bool {
        return loginViewModel.retrieveAccountWithUser(credentials: credentials)
    }
    
    func createAccountAndLogin(credentials: Credentials) -> Bool {
        if loginViewModel.retrieveAccountWithUser(credentials: credentials) {
            return true
        }
        return loginViewModel.createAccountWith(credentials: credentials)
    }
}
