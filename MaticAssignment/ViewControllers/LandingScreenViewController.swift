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
        let loginVC = LoginViewController.get(mode: mode)
        return loginVC
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        // get login View controller
        // set title text and button text
        let loginVC = setUpLoginViewController(mode: SIGN_IN)
        present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func newAccountButtonPressed(_ sender: UIButton) {
        let loginVC = setUpLoginViewController(mode: CREATE_ACCOUNT)
        present(loginVC, animated: true, completion: nil)
    }
}
