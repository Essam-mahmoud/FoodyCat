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
    @IBOutlet weak var deleteButton: UIButton!
    var deleteTapped: ((AddressCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: AddressData,isFromSideMenue: Bool) {
        addressTitleLabel.text = data.name
        addressLabel.text = data.addressLineOne
        userNameLabel.text = SharedData.SharedInstans.getUserName()
        phoneNumberLabel.text = data.phone
        deleteButton.isHidden = isFromSideMenue ? false : true
    }

    @IBAction func deleteButtonDidPress(_ sender: UIButton) {
        deleteTapped?(self)
    }
}
