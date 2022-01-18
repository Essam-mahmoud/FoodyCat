//
//  MealsCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import UIKit
import SwiftUI

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

    func setupCell(data: Item) {
        mealImage.loadImageFromUrl(imgUrl: data.imgFullPath, defString: "imageplaceholder")
        mealNameLabel.text = data.name
        mealDiscriptionLabel.text = data.itemDescription
        mealPriceLabel.text = "KWD".localized() + " \(data.price ?? 0)"
    }
    
    @IBAction func addButtonDidPress(_ sender: UIButton) {
        addTapped?(self)
    }

}
