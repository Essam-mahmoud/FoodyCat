//
//  GTButton.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/7/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit
import TransitionButton


@IBDesignable
class GTButton: TransitionButton {
    override func stopAnimation(animationStyle: StopAnimationStyle, revertAfterDelay delay: TimeInterval, completion: (() -> Void)?) {
        super.stopAnimation(animationStyle: animationStyle, revertAfterDelay: delay, completion: completion)
        super.stopAnimation(animationStyle: animationStyle, revertAfterDelay: delay) {[weak self] in
            if self?.roundIt ?? false  {
                self?.layer.cornerRadius = (self?.frame.height ?? 0.0) / 2
                self?.layer.masksToBounds = ((self?.frame.height ?? 0.0) / 2) > 0
                self?.layoutIfNeeded()
            }
        }
    }
    func stopAnimation(){
        stopAnimation(animationStyle: .normal, revertAfterDelay: 0.1) {
            
        }
    }
    @IBInspectable var localizeAlignemt: Bool = false  {
        didSet{
            if localizeAlignemt {
                contentHorizontalAlignment = LanguageManager.getTextAlignment()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        GTButton.setCustomFontFor(btn: self)
    }
    class func setCustomFontFor(btn:UIButton){
        let size  = btn.titleLabel?.font.pointSize
        if LanguageManager.isArabic() {
            let fontName = (btn.titleLabel?.font.isBold)! ? LanguageManager.Font.ARABIC_FONT_BOLD : LanguageManager.Font.ARABIC_FONT_REGULAR
            btn.titleLabel?.font = UIFont.init(name: fontName, size: size!)
        }else {
            let fontName = (btn.titleLabel?.font.isBold)! ? LanguageManager.Font.ENGLISH_FONT_BOLD : LanguageManager.Font.ENGLISH_FONT_REGULAR
            btn.titleLabel?.font = UIFont.init(name: fontName, size: size!)
        }
    }
    
    class func forceArabicFontFor(btn:UIButton){
        let size  = btn.titleLabel?.font.pointSize
            let fontName = (btn.titleLabel?.font.isBold)! ? LanguageManager.Font.ARABIC_FONT_BOLD : LanguageManager.Font.ARABIC_FONT_REGULAR
            btn.titleLabel?.font = UIFont.init(name: fontName, size: size!)
    }
    
    
    class func forceEnglishFontFor(btn:UIButton){
        let size  = btn.titleLabel?.font.pointSize
        let fontName = (btn.titleLabel?.font.isBold)! ? LanguageManager.Font.ENGLISH_FONT_BOLD : LanguageManager.Font.ENGLISH_FONT_REGULAR
        btn.titleLabel?.font = UIFont.init(name: fontName, size: size!)
    }
    
    @IBInspectable
    var localizedTitle: String = "" {
        didSet{
            setTitle(localizedTitle.localized(), for: .normal)
        }
        
    }
    @IBInspectable
    var localizedBackgroundImage: String = ""{
        didSet{
            setBackgroundImage(UIImage(named: localizedBackgroundImage.localized()), for: .normal)
        }
    }
    @IBInspectable var roundIt: Bool = false  {
        didSet{
            if roundIt {
                layer.cornerRadius = frame.height / 2
                layer.masksToBounds = (frame.height / 2) > 0
                
            }
        }
    }
}

@IBDesignable
class MZTabBarItem: UITabBarItem{
    @IBInspectable
    var localizedTitle: String = ""{
        didSet{
            title = localizedTitle.localized()
            setTitleTextAttributes( [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(fontSize: 10)], for: .normal)
        }
    }
}

@IBDesignable
class MZBarButtonItem: UIBarButtonItem{
   
    @IBInspectable
    var localizedImage: String = ""{
        didSet{
            image = UIImage(named: localizedImage.localized())
        }
    }
    var localizedTitle: String = ""{
        didSet{
            title = localizedTitle.localized()
//            image = UIImage(named: localizedImage.localized())
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
@IBDesignable
class MZCheckBtn: GTButton{
    
   
    override func awakeFromNib() {

        addTarget(self, action: #selector(toggleCheck)
            , for: UIControl.Event.touchUpInside)
    }
    @objc func toggleCheck(){
        if backgroundImage(for: .normal) == UIImage(named: "checked"){
            setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        }else{
            setBackgroundImage(UIImage(named: "checked"), for: .normal)
        }
    }
    func checkWithStatus(status:Bool){
        setBackgroundImage(status ? UIImage(named: "checked") : UIImage(named: "unchecked"), for: .normal)

    }
    var isChecked : Bool {
        return backgroundImage(for: .normal) == UIImage(named: "checked")
    }
}
