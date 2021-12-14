//
//  GTTextView.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/7/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class GTTextView: UITextView ,UITextViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        GTTextView.setCustomFontFor(txtView: self)
        updateAlignmentUI()
        configureUI()
        self.delegate = self
        self.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
         //  your code here
        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        //  your code here
       
        textView.borderWidth = 2
        textView.borderColor = UIColor(named: "tealish")!
        
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
         //  your code here
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
       // your code here
        textView.borderWidth = 0
        textView.borderColor = .clear
    }
    func configureUI(){

    }
    @objc func dismissBtn(){
        resignFirstResponder()
    }
    
    class func setCustomFontFor(txtView:GTTextView){
        let size  = txtView.font?.pointSize
        if LanguageManager.isArabic() {
            let fontName = (txtView.font?.isBold)! ? LanguageManager.Font.ARABIC_FONT_BOLD : LanguageManager.Font.ARABIC_FONT_REGULAR
            txtView.font = UIFont.init(name: fontName, size: size!)
        }else {
            let fontName = (txtView.font?.isBold)! ? LanguageManager.Font.ENGLISH_FONT_BOLD : LanguageManager.Font.ENGLISH_FONT_REGULAR
            txtView.font = UIFont.init(name: fontName, size: size!)
        }
    }
    func updateAlignmentUI(){
        if self.textAlignment == .natural {
            self.textAlignment = Util.UI.getTextAlignment()
        }
    }
    
    
    @IBInspectable var localizedText: String = ""{
        didSet{
            text = localizedText.localized()
        }
        
    }
    @IBInspectable var localizedPlaceHolder: String = ""{
        didSet{
            placeholder = localizedPlaceHolder.localized()
        }
        
    }
}
