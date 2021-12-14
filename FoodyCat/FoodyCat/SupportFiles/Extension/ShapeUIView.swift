//
//  ShapeUIView.swift
//  PollingTemplate
//
//  Created by Ahmed Wahdan on 10/22/18.
//  Copyright © 2018 Ahmed Wahdan. All rights reserved.
//

import UIKit

extension UIView {
//    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
    //        YourView.roundCorners([.topLeft, .bottomLeft], radius: 10)
}
extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
