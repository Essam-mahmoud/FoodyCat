//
//  UIColor+Extension.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/20/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    internal convenience init(hex: Int) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255,
            blue: CGFloat(hex & 0x0000FF) / 255,
            alpha: 1
        )
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    
    }
    struct BackColor {
        static var green = Util.UI.babyPukeGreen
        static var white = UIColor.white
        static var black = UIColor.lightGray
    }
    
    class func hexColor(string: String) -> UIColor {
        let set = NSCharacterSet.whitespacesAndNewlines
        var colorString = string.trimmingCharacters(in: set).uppercased()
        
        if (colorString.hasPrefix("#")) {
            let index = colorString.index(after: colorString.startIndex)
            colorString = String(colorString[index..<colorString.endIndex])
        }
        
        if (colorString.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        
        
        
    }
    
    class func hexColorWithAlpha(string: String, alpha:CGFloat) -> UIColor {
        let set = NSCharacterSet.whitespacesAndNewlines
        var colorString = string.trimmingCharacters(in: set).uppercased()
        
        if (colorString.hasPrefix("#")) {
            let index = colorString.index(after: colorString.startIndex)
            colorString = String(colorString[index..<colorString.endIndex])
        }
        
        if (colorString.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
        
        
        
    }
    
    
}

extension UIColor {

  @nonobjc class var aquaMarine: UIColor {
    return UIColor(red: 79.0 / 255.0, green: 208.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var black: UIColor {
    return UIColor(white: 0.0, alpha: 1.0)
  }

  @nonobjc class var grapefruit: UIColor {
    return UIColor(red: 232.0 / 255.0, green: 104.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var slate: UIColor {
    return UIColor(red: 84.0 / 255.0, green: 85.0 / 255.0, blue: 112.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var darkBlueGrey: UIColor {
    return UIColor(red: 17.0 / 255.0, green: 30.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var white: UIColor {
    return UIColor(white: 1.0, alpha: 1.0)
  }

  @nonobjc class var purpleBrown: UIColor {
    return UIColor(red: 34.0 / 255.0, green: 31.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var brownishGrey: UIColor {
    return UIColor(white: 112.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var pale: UIColor {
    return UIColor(red: 234.0 / 255.0, green: 232.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var darkGreyBlue: UIColor {
    return UIColor(red: 38.0 / 255.0, green: 61.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var darkPeach: UIColor {
    return UIColor(red: 235.0 / 255.0, green: 119.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var butterscotch: UIColor {
    return UIColor(red: 241.0 / 255.0, green: 187.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var darkIndigo5: UIColor {
    return UIColor(red: 12.0 / 255.0, green: 13.0 / 255.0, blue: 52.0 / 255.0, alpha: 0.05)
  }

  @nonobjc class var tealish: UIColor {
    return UIColor(red: 44.0 / 255.0, green: 185.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var darkIndigo: UIColor {
    return UIColor(red: 12.0 / 255.0, green: 13.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
  }

}
