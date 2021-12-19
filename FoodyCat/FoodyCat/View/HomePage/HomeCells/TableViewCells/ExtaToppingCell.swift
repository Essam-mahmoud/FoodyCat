//
//  ExtaToppingCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 17/12/2021.
//

import UIKit

class ExtaToppingCell: UITableViewCell {

    @IBOutlet weak var itemButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!

    var selectedTapped: ((ExtaToppingCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: ExtraItem) {
        itemButton.setImage(data.isSelected ?? false ? #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "uncheck"), for: .normal)
        itemNameLabel.text = data.title
        itemPriceLabel.text = "KWD".localized() + " \(data.price ?? 0)"
    }
    @IBAction func selectButtonDidPress(_ sender: UIButton) {
        selectedTapped?(self)
    }
}
