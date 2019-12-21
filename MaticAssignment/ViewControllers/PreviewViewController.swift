//
//  PreviewViewController.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/22/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    
    static func get() -> PreviewViewController {
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: PreviewViewController.name) as! PreviewViewController
        return controller
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
