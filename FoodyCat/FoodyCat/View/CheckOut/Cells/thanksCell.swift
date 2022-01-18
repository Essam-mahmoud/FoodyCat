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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
