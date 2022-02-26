//
//  RestaurantCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import UIKit
import Cosmos

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorSpecialityLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: VendorsData) {
        vendorImage.loadImageFromUrl(imgUrl: data.coverImage, defString: "vendorPlaceHolder")
        vendorNameLabel.text = data.name
        vendorSpecialityLabel.text = data.cuisines
        timeLabel.text = "\(data.averageDeliveryTime ?? 0)" + " " + "min".localized()
        deliveryLabel.text = "\(data.deliveryCharge ?? 0)" + " " + "KWD".localized()
        ratingView.rating = Double(data.rating ?? 0)
        ratingView.isUserInteractionEnabled = false
    }
}
