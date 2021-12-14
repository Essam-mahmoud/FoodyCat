//
//  LanguageManager.swift

import UIKit
import Localize_Swift
import MOLH
class LanguageManager: NSObject {
    struct Font {
        static let ENGLISH_FONT_REGULAR = "CircularStd-Medium"
        static let ENGLISH_FONT_BOOK = "CircularStd-Book"
        static let ENGLISH_FONT_Medium = "CircularStd-Medium"
        static let ENGLISH_FONT_BOLD = "CircularStd-Bold"
        static let ARABIC_FONT_REGULAR = "DroidArabicKufi"
        static let ARABIC_FONT_BOLD = "DroidArabicKufi-Bold"
    }
    
    static var languageId :String {
        return LanguageManager.isArabic() ? "ar":"en"
    }
    static var localizedTitleInset :UIEdgeInsets {
        return LanguageManager.isArabic() ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8) : UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    class func isArabic()->Bool{
        return MOLHLanguage.isArabic()
    }
    class func initAppConfiguration(){
        MOLH.shared.activate(true)
        
        if MOLHLanguage.isArabic(){
            LanguageManager.switchToArabic()
        }else {
            LanguageManager.switchToEnglish()
        }
        UIFont.overrideInitialize()
        
    }
    class func switchLanguage()  {
        if LanguageManager.isArabic() {
            LanguageManager.switchToEnglish()
        }else{
            LanguageManager.switchToArabic()
        }
    }
    class func switchToArabic(){
        if !LanguageManager.isArabic() {
            MOLH.setLanguageTo("ar")
            Localize.setCurrentLanguage("ar")
            MOLH.reset()
            AppCommon.sharedInstance.resetRootIntro()
        }
    }
    class func switchToEnglish(){
        if LanguageManager.isArabic() {
            MOLH.setLanguageTo("en")
            Localize.setCurrentLanguage("en")
            MOLH.reset()
            AppCommon.sharedInstance.resetRootIntro()
        }
    }
    class func getLanguageCode()->String{
        if LanguageManager.isArabic(){
            return "arabic"
        }
        return "english"
    }
    class func getTextAlignment()->NSTextAlignment{
        if LanguageManager.isArabic() {
            return .right
        }else {
            return .left
        }
    }
    class func getTextAlignment()->UIControl.ContentHorizontalAlignment{
        if LanguageManager.isArabic() {
            return .right
        }else {
            return .left
        }
    }
    class func getEnglishLocalForAppLanuage() -> Locale? {
        let locale = Locale.init(identifier: "en")
        return locale
    }
    
    class func getArabicLocalForAppLanuage() -> Locale? {
        let locale = Locale.init(identifier: "ar")
        return locale
    }
    class func getLangForApiPath() -> String {
        if LanguageManager.isArabic() {
            return "arabic"
        }else{
            return "english"
        }
    }
    class func getLocale() -> Locale? {
        if isArabic(){
            return getArabicLocalForAppLanuage()
        }
        return getEnglishLocalForAppLanuage()
    }
    
    class func getCurrentLanguage()-> String{
        if isArabic() {
            return "Arabic".localized()
        }
        return "English".localized()
    }
    class func getLocalizedFont(fontSize:CGFloat = 16.0)->UIFont{

        //        for family in UIFont.familyNames.sorted(){
        //            let name = UIFont.fontNames(forFamilyName: family)
        //            print("family : \(family) font name: \(name)")
        //        }
        //
        if isArabic() {
            return UIFont.init(name: LanguageManager.Font.ARABIC_FONT_REGULAR, size: fontSize)!
        }
        return UIFont.init(name:LanguageManager.Font.ENGLISH_FONT_REGULAR , size: fontSize)!
        //
    }
    class func getLocalizedBoldFont(fontSize:CGFloat = 16.0)->UIFont{
        if isArabic() {
            return UIFont.init(name: LanguageManager.Font.ARABIC_FONT_BOLD, size: fontSize)!
            //
        }
        return UIFont.init(name:  LanguageManager.Font.ENGLISH_FONT_BOLD , size: fontSize)!
        //
    }
    class func toggleLanguage(){
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
    }
    
    
}
