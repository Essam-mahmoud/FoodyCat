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

    var deleteTapped: (() -> Void)?
    var increaseTapped: (() -> Void)?
    var decreaseTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell() {

    }

    @IBAction func deleteButtonDidPress(_ sender: UIButton) {
    }

    @IBAction func increaseButtonDidPress(_ sender: UIButton) {
    }

    @IBAction func decreaseButtonDidPress(_ sender: UIButton) {
    }

}
