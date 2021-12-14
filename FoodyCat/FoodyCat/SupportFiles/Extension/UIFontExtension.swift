//
//  UIFontExtension.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/7/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit

extension UIFont {
    var isBold: Bool {
        return (fontDescriptor.symbolicTraits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) > 0
    }
    
    var isItalic: Bool {
        return (fontDescriptor.symbolicTraits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) > 0
    }
}
