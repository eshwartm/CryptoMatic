//
//  LandingScreenViewController.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import UIKit

class LandingScreenViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var newAccountButton: UIButton!
    
    class func get() -> LandingScreenViewController {
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: LandingScreenViewController.name) as! LandingScreenViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func setUpLoginViewController(mode: String) -> LoginViewController {
        let loginVC = LoginViewController.get()
        loginVC.loadViewIfNeeded()
        switch mode {
        case LOGIN_ACTION:
            loginVC.titleLabel.text = SIGN_IN
            loginVC.loginOrSignUpButton.setTitle(SIGN_IN, for: .normal)
        case SIGNUP_ACTION:
            loginVC.titleLabel.text = CREATE_ACCOUNT
            loginVC.loginOrSignUpButton.setTitle(CREATE_ACCOUNT, for: .normal)
        default:
            loginVC.titleLabel.text = SIGN_IN
            loginVC.loginOrSignUpButton.setTitle(SIGN_IN, for: .normal)
        }
        return loginVC
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        // get login View controller
        // set title text and button text
        let loginVC = setUpLoginViewController(mode: LOGIN_ACTION)
        present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func newAccountButtonPressed(_ sender: UIButton) {
        let loginVC = setUpLoginViewController(mode: SIGNUP_ACTION)
        present(loginVC, animated: true, completion: nil)
    }
}
