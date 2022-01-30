//
//  SavedAddressCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 25/01/2022.
//

import UIKit

class SavedAddressCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: SavedAddressesModel) {
        addressLabel.text = data.address
        areaLabel.text = data.areaName
    }
}
