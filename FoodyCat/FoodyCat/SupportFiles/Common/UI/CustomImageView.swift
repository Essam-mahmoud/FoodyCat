//
//  CustomImageView.swift
//  Mabiatak
//
//  Created by  on 8/21/19.
//

import UIKit

class CustomImageView: UIImageView {

        override func didMoveToSuperview() {
            if LanguageManager.isArabic() 
        {
            self.image = UIImage(cgImage: (self.image?.cgImage)!, scale: 1.0, orientation: .upMirrored)
        }
    }
    

}

