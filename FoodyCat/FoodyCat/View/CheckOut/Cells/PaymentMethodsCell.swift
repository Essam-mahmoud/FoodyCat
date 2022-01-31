//
//  PaymentMethodsCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 02/01/2022.
//

import UIKit

class PaymentMethodsCell: UITableViewCell {

    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var paymentImage: UIImageView!
    @IBOutlet weak var paymentNameLabel: UILabel!

    var selectedTapped: ((PaymentMethodsCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(data: PaymentMethods, isSelected: Bool) {
        selectedButton.setImage(isSelected ? UIImage(named: "check") : UIImage(named: "uncheck") , for: .normal)
        paymentImage.loadImageFromUrl(imgUrl: data.icon, defString: "celebrityPlaceHolder")
        paymentNameLabel.text = data.title
    }
    
    @IBAction func selectedButtonDidPress(_ sender: UIButton) {
        selectedTapped?(self)
    }
}
