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
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: "", type: NVActivityIndicatorType.lineScale)
    }
    

}
