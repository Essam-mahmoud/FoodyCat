//
//  SideMenuCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 16/04/2022.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(itemImageName: String, itemName: String) {
        itemNameLabel.text = itemName
        itemImage.image = UIImage(systemName: itemImageName)
    }
    
}
