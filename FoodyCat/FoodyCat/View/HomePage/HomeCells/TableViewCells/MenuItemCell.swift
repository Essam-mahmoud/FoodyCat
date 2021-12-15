//
//  MenuItemCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 14/12/2021.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!

    var addTapped: ((MenuItemCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: Item) {
        itemImage.loadImageFromUrl(imgUrl: data.imgFullPath, defString: "imageplaceholder")
        itemNameLabel.text = data.name
        itemDescriptionLabel.text = data.itemDescription
        itemPriceLabel.text = "KWD".localized() + "\(data.price ?? 0.0)"
    }
    @IBAction func addToBasketButtonPressed(_ sender: UIButton) {
        addTapped?(self)
    }
}
