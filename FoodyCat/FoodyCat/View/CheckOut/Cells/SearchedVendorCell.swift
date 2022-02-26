//
//  SearchedVendorCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 26/02/2022.
//

import UIKit

class SearchedVendorCell: UITableViewCell {

    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorDescription: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: VendorsData) {
        vendorName.text = data.name
        vendorImage.loadImageFromUrl(imgUrl: data.logo, defString: "celebrityPlaceHolder")
        vendorDescription.text = data.cuisines
        timeLabel.text = "\(data.averageDeliveryTime ?? 0)" + " " + "min".localized()
        deliveryLabel.text = "\(data.deliveryCharge ?? 0)" + " " + "KWD".localized()
    }
    
}
