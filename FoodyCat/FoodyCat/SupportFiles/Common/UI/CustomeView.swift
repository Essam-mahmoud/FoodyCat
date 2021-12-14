//
//  CustomeView.swift
//  glamera
//
//  Created by Smart Zone on 9/20/19.
//  Copyright © 2019 taha . All rights reserved.
//

import UIKit
//import SkyFloatingLabelTextField

extension UIColor{
    public static let grayColor = UIColor(red: 188.0/255.0, green: 188.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    public static let purpleColor = UIColor(red: 158.0/255.0, green: 69.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    public static let orangeColor = UIColor(red: 251.0/255.0, green: 137.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    public static let bgGrayColor = UIColor(red: 196.0/255.0, green: 198.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    public static let darkPurpleColor = UIColor(red: 88.0/255.0, green: 55.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    public static let lightBlackColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5)
    public static let lightGrayColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)

}
class Slider: UISlider {
    
    @IBInspectable var thumbImage: UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
        if let thumbImage = thumbImage {
            self.setThumbImage(thumbImage, for: .normal)
            self.setThumbImage(thumbImage, for: .highlighted)
        }
    }

}
extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}
extension UICollectionViewCell {
    
    var collectionView: UICollectionView? {
        return next(UICollectionView.self)
    }
    
    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }
    
}
// make table view scroll when touch textfield ...
extension UITableView {
    override open func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UITextField || view is UITextView || view is UIButton{
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}

extension UITableView{
    func numberOfRows(count:Int) -> Int
    {
        var numOfRows : Int = 0
        if count > 0
        {
            numOfRows = count
            self.backgroundView = nil
        }
        else
        {
            let emptyImage = UIImage(named: "empty2")
            let emptyImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 210, height: 207))
            emptyImageView.image = emptyImage
            self.backgroundView = emptyImageView
        }
        return numOfRows
    }
    
}
extension UICollectionView {
    func numberOfRows(count:Int) -> Int
    {
        var numOfRows : Int = 0
        if count > 0
        {
            numOfRows = count
            self.backgroundView = nil
        }
        else
        {
            let emptyImage = UIImage(named: "empty2")
            let emptyImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 210, height:207))
            emptyImageView.image = emptyImage
            self.backgroundView = emptyImageView
        }
        return numOfRows
    }
}

extension UITextField{
    open override func didMoveToSuperview() {
        if textAlignment != .center
        {
            if  LanguageManager.languageId == "ar" {
                textAlignment = .right
            } else {
                textAlignment = .left
            }
        }
    }
}
extension UITextView{
    open override func didMoveToSuperview() {
        if  LanguageManager.languageId == "ar" {
            textAlignment = .right
        } else {
            textAlignment = .left
        }
    }
}
extension UILabel{
    open override func didMoveToSuperview() {
        if textAlignment != .center
        {
            if  LanguageManager.languageId == "ar" {
                textAlignment = .right
//                .locale = Locale(identifier: "en_US")
            } else {
                textAlignment = .left
            }
        }
        
    }
}
public extension String {

    var replacedEnglishDigitsWithArabic: String {
    var str = self
    let map = ["0": "٠",
               "1": "١",
               "2": "٢",
               "3": "٣",
               "4": "٤",
               "5": "٥",
               "6": "٦",
               "7": "٧",
               "8": "٨",
               "9": "٩",
               "/": "/",
               "-": "-"
        ]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str
}
}
extension String {
    func convertEngNumToArabicNum()->String{
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        let number =   format.number(from: self)

        let faNumber = format.string(from: number!)
        return faNumber!

    }
    func convertToArabic()-> String {
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = self

        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }

        return str
    }
}

