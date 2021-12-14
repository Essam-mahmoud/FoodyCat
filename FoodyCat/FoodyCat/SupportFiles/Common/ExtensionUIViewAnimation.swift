//
//  ExtensionUIViewAnimation.swift
//  JOSOR
//
//  Created by Ahmed Wahdan on 8/4/20.
//  Copyright © 2020 Ahmed Wahdan. All rights reserved.
//

import UIKit

public extension UIView {
    func shake() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.transform))
        animation.valueFunction = CAValueFunction(name: .translateX)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.8
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }
    
    func wiggle() {
        guard layer.animation(forKey: "wiggle") == nil else { return }
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.transform))
        animation.duration = 0.115
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.values = [
            CATransform3DMakeRotation(0.04, 0.0, 0.0, 1),
            CATransform3DMakeRotation(-0.04, 0, 0, 1)
        ]
        layer.add(animation, forKey: "wiggle")
    }
    
    func stopWiggling() {
        layer.removeAnimation(forKey: "wiggle")
    }
}


extension UIView {
    func blurView(){
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }

    func darkBlurView(){
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
