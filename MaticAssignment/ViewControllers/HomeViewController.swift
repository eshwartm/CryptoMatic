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
    
    var viewModel: HomeViewModel!
    
    class func get(credentials: Credentials) -> HomeViewController {
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: HomeViewController.name) as! HomeViewController
        homeVC.viewModel = HomeViewModel(credentials: credentials)
        return homeVC
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
        let hash = viewModel.salt
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
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    
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
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let cellData = self.viewModel.cryptoItemAtIndex(index: indexPath.row)!
        let cryptoName = cellData.name
        let imgName = cellData.symbol.lowercased()
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
            // Return Preview View Controller here
            let previewController = PreviewViewController.get()
            previewController.loadViewIfNeeded()
            previewController.imageView.image = UIImage(named: imgName)
            previewController.cryptoNameLabel.text = cryptoName
            return previewController
        }) { _ -> UIMenu? in
            let action = UIAction(title: "Close") { (action) in
                
            }
            return UIMenu(title: "", image: UIImage(named: cryptoName), identifier: nil, options: [UIMenu.Options.destructive/*, UIMenu.Options.displayInline*/], children: [action])
        }
        return configuration
    }
    
    
}
