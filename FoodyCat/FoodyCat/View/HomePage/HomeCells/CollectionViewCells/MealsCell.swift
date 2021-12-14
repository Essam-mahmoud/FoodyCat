//
//  MealsCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import UIKit

class MealsCell: UICollectionViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealDiscriptionLabel: UILabel!
    @IBOutlet weak var mealPriceLabel: UILabel!

    var addTapped: ((MealsCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func addButtonDidPress(_ sender: UIButton) {
        addTapped?(self)
    }

}
