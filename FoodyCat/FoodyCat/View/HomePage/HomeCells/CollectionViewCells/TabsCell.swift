//
//  TabsCell.swift
//  FoodyCat
//
//  Created by Essam Orabi on 14/12/2021.
//

import UIKit

class TabsCell: UICollectionViewCell {

    @IBOutlet weak var tabeNameLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool {
        didSet {
            tabeNameLabel.textColor = isSelected ? #colorLiteral(red: 0.1333333333, green: 0.168627451, blue: 0.2705882353, alpha: 1) : #colorLiteral(red: 0.5607843137, green: 0.6078431373, blue: 0.7019607843, alpha: 1)
            indicatorView.backgroundColor = isSelected ? #colorLiteral(red: 0.968627451, green: 0.5960784314, blue: 0.1411764706, alpha: 1) : #colorLiteral(red: 0.9294117647, green: 0.9450980392, blue: 0.968627451, alpha: 1)
        }
    }
}
