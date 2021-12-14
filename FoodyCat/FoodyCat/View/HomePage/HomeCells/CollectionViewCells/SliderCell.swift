//
//  SliderCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 11/12/2021.
//

import UIKit

class SliderCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell() {
        bannerImage.loadImageFromUrl(imgUrl: "", defString: "imageplaceholder")
    }

}
