//
//  SearchedCelebrityCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 26/02/2022.
//

import UIKit

class SearchedCelebrityCell: UICollectionViewCell {

    @IBOutlet weak var celebrityImage: UIImageView!
    @IBOutlet weak var celebrityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: CeleberitiesData) {
        celebrityName.text = data.name
        celebrityImage.loadImageFromUrl(imgUrl: data.mediaFullPath, defString: "celebrityPlaceHolder")
    }
}
