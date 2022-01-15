//
//  AddressCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/12/2021.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: AddressData) {
        addressTitleLabel.text = data.name
        addressLabel.text = data.addressLineOne
        userNameLabel.text = ""
        phoneNumberLabel.text = ""
    }
}
