//
//  MyOrdersCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 31/01/2022.
//

import UIKit

class MyOrdersCell: UITableViewCell {

    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorIdLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(data: Order) {
        vendorNameLabel.text = data.vendor?.name
        vendorIdLabel.text = "\(data.id ?? 0)"
        vendorImage.loadImageFromUrl(imgUrl: data.vendor?.logoFullPath, defString: "itemPlaceHolder")
        numberOfItemsLabel.text = "\(data.listOfCart?.count ?? 0) " + "items".localized()
        statusLabel.text = data.currentStepString
    }
}
