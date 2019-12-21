//
//  HomeViewController.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var showHashButton: UIButton!
    @IBOutlet weak var homeTableView: UITableView!
    
    var viewModel = HomeViewModel()
    
    class func get() -> HomeViewController {
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: HomeViewController.name) as! HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.tableFooterView = UIView(frame: .zero)
        homeTableView.register(CryptoTableViewCell.cryptoTableViewCellNib,
                               forCellReuseIdentifier: CryptoTableViewCell.identifier)
        setupBindingAndGetCryptos()
    }
    
    @IBAction func showHashButtonPressed(_ sender: UIButton) {
        let hash = viewModel.retrieveHash()
        let msg = (hash == "") ? "Could not retrieve hash" : hash
        self.showAlertWithTitleAndText(title: "Message", text: msg)
    }
    
    func setupBindingAndGetCryptos() {
        viewModel.cryptos.bind { [unowned self] (cryptos) in
            self.homeTableView.reloadData()
        }
        
        viewModel.getAllCryptos()
    }
}

// UITableViewControllerPreviewingDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cryptosCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCellWithViewModel(crypto: viewModel.cryptoItemAtIndex(index: indexPath.row) ?? nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
    }
    
}
