//
//  RestaurantCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import UIKit
import Cosmos
import SwiftUI

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorSpecialityLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusView: CardView!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: VendorsData) {
        vendorImage.loadImageFromUrl(imgUrl: data.coverImage, defString: "vendorPlaceHolder")
        vendorNameLabel.text = data.name
        vendorSpecialityLabel.text = data.cuisines
        timeLabel.text = "\(data.averageDeliveryTime ?? 0)" + " " + "min".localized()
        deliveryLabel.text = String(format: "%.2f", data.deliveryCharge ?? 0) + " " + "KWD".localized()
        ratingView.rating = Double(data.rating ?? 0)
        ratingView.isUserInteractionEnabled = false
        guard let open = data.vendorOpen else {return}
        if !open {
            statusView.isHidden = false
            statusView.backgroundColor = UIColor.red
            statusLabel.text = "Closed".localized()
        } else {
            if data.busy ?? false{
                statusView.isHidden = false
                statusView.backgroundColor = UIColor.init(named: "mango")
                statusLabel.text = "Busy".localized()
            } else {
                statusView.isHidden = true
            }
        }
    }
}
