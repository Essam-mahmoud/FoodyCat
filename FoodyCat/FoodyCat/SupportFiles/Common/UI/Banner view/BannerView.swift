//
//  BannerView.swift
//  shofha
//
//  Created by mohamed on 2/6/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import UIKit
enum BannerColorCode : Int {
    case success = 0x93cc2f
    case failure = 0xe84c3d
    case other = 0x5b41b3
}
class BannerView: GTView {

    @IBOutlet weak var messageLabel: GTLabel?
    
    var message  :String?
    var preferedColor : UIColor?
    let showAnimation = 2.5
    class func showAlert(message:String,colorCode:BannerColorCode, isChecknet:Bool = false){
        let view = Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)?.first as? BannerView
         view?.message = message
        view?.preferedColor = UIColor(hex: colorCode.rawValue)
        if isChecknet == false
        {
        view?.configure()
        }else{
             view?.configureInternet()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var updatedFrame = frame
        updatedFrame.size.width = UIScreen.main.bounds.width
    }
    
    private func configure(){
        messageLabel?.text = message
        backgroundColor = preferedColor
        let height : CGFloat = UINavigationController().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height 
        
        var updatedFrame = CGRect(x: 0, y: -1 * height, width: UIScreen.main.bounds.width, height: height)
        self.frame  = updatedFrame

        if #available(iOS 13.0, *) {
            SceneDelegate.shared?.window?.addSubview(self)
        } else {
            AppDelegate.getIntance().window?.addSubview(self)
        }
      

        
        UIView.animate(withDuration: 0.3, animations: {
            updatedFrame.origin.y = 0
            self.frame = updatedFrame
        }) { (finished) in
            if finished {
                self.perform(#selector(self.hide), with: nil, afterDelay: self.showAnimation)
            }
        }
        
    }
    
    private func configureInternet(){
       
        backgroundColor = preferedColor
        let height : CGFloat =  UIApplication.shared.statusBarFrame.height
        
        var updatedFrame = CGRect(x: 0, y: -1 * height, width: UIScreen.main.bounds.width, height: height)
        self.frame  = updatedFrame

        if #available(iOS 13.0, *) {
            SceneDelegate.shared?.window?.addSubview(self)
        } else {
            AppDelegate.getIntance().window?.addSubview(self)
        }
      

        
        UIView.animate(withDuration: 0.3, animations: {
            updatedFrame.origin.y = 0
            self.frame = updatedFrame
        })
        
    }
    
    @objc private func hide(){
        var currentFrame = self.frame
        UIView.animate(withDuration: 0.3, animations: {
            currentFrame.origin.y = currentFrame.size.height * -1
            self.frame = currentFrame
        }) { (finished) in
            if finished {
                self.removeFromSuperview();
            }
        }
    }
    
    
}
