//
//  ToastHelper.swift
//  JOSOR
//
//  Created by Ahmed Wahdan on 8/10/20.
//  Copyright © 2020 Ahmed Wahdan. All rights reserved.
//

import UIKit

class ToastHelper {
    // MARK: Helper Functions
    func showAlert(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .white
        alert.view.layer.cornerRadius = 15
        alert.view.alpha = 0.6
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alert, animated: true)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
//            alert.dismiss(animated: true)
//        }
    }
}
