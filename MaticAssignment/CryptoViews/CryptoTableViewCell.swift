//
//  CryptoTableViewCell.swift
//  MaticAssignment
//
//  Created by Eshwar Ramesh on 12/20/19.
//  Copyright © 2019 Eshwar Ramesh. All rights reserved.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cryptoTitleLabel: UILabel!
    @IBOutlet weak var cryptoSubtitleLabel: UILabel!
    
    static let identifier = CryptoTableViewCell.name
    static let cryptoTableViewCellNib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithViewModel(crypto: CryptoModel?) {
        guard let crypt = crypto else {
            cryptoTitleLabel.text = "Title"
            cryptoSubtitleLabel.text = "Subtitle"
            imgView.image = UIImage(named: "FavouriteButton")
            return
        }
        let viewModel = CryptoViewModel(crypto: crypt)
        cryptoTitleLabel.text = viewModel.name
        cryptoSubtitleLabel.text = viewModel.name
        imgView.image = UIImage(named: viewModel.iconName)
    }
    
}
