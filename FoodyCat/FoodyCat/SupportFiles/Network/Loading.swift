//
//  Loading.swift
//  KickStartMapDemo
//
//  Created by Taha Hamdy on 9/22/19.
//  Copyright © 2019 Taha Hamdy All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class Loading: UIViewController,NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loading (){
        let size = CGSize(width: 50, height: 50)
        //startAnimating(size, message: "", type: NVActivityIndicatorType.ballClipRotate)
        startAnimating(size, message: "Loading...".localized(), type: NVActivityIndicatorType.ballClipRotate, color: #colorLiteral(red: 0.4274509804, green: 0.06666666667, blue: 0.568627451, alpha: 1))
    }
}
