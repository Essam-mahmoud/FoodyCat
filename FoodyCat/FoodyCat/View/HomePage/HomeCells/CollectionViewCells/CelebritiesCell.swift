//
//  CelebritiesCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 12/12/2021.
//

import UIKit

class CelebritiesCell: UICollectionViewCell {

    @IBOutlet weak var celebrityImage: UIImageView!
    @IBOutlet weak var celebrityNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: CeleberitiesData) {
        DispatchQueue.main.async {
            self.celebrityImage.roundCorners([.topRight,.topLeft], radius: 15)
            self.celebrityImage.layer.masksToBounds = true
            self.celebrityImage.loadImageFromUrl(imgUrl: data.mediaFullPath, defString: "avatarPlaceHolder")
            self.celebrityNameLabel.text = data.name
        }
    }

}
