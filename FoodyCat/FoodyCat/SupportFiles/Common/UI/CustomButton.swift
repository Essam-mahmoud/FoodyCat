//
//  CustomButton.swift
//  glamera
//
//  Created by  on 10/1/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class CustomButton: UIButton {
        override func didMoveToSuperview() {
            if LanguageManager.languageId == "ar"
            {
                self.imageView?.transform = self.imageView!.transform.rotated(by: CGFloat.pi)
            }
        }
}
