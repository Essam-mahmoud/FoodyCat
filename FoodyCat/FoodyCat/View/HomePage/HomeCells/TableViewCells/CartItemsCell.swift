//
//  CartItemsCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/12/2021.
//

import UIKit

class CartItemsCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemCounterLabel: UILabel!

    var deleteTapped: ((CartItemsCell) -> Void)?
    var increaseTapped: ((CartItemsCell) -> Void)?
    var decreaseTapped: ((CartItemsCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: ItemOrderModel) {
        itemNameLabel.text = data.itemName
        itemDescriptionLabel.text = data.itemDescription
        itemPriceLabel.text = String(format: "%.2f", data.itemtotalPrice)
        itemCounterLabel.text = "\(data.quantity)"
    }

    @IBAction func deleteButtonDidPress(_ sender: UIButton) {
        deleteTapped?(self)
    }

    @IBAction func increaseButtonDidPress(_ sender: UIButton) {
        increaseTapped?(self)
    }

    @IBAction func decreaseButtonDidPress(_ sender: UIButton) {
        decreaseTapped?(self)
    }

}
