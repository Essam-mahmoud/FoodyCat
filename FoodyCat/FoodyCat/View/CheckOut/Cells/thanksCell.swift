//
//  thanksCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/01/2022.
//

import UIKit

class thanksCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: ItemOrderModel) {
        quantityLabel.text = "\(data.quantity)"
        nameLabel.text = data.itemName
    }

    func setupCellList(data: ListOfCart) {
        quantityLabel.text = "\(data.qty ?? 0)"
        nameLabel.text = data.name
    }
}
