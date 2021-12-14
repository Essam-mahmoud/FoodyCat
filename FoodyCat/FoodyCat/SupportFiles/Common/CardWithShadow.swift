//
//  CardWithShadow.swift
//  Glamera Business
//
//  Created by Apple on 2/12/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit

@IBDesignable
class CardWithShadow: UIView {
    
    @IBInspectable var _cornerRadius: CGFloat = 5
    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var _shadowColor: UIColor? = UIColor.gray
    @IBInspectable var _shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = _cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: _cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = _shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = _shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
