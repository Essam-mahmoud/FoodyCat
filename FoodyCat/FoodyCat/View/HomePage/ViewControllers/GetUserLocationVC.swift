//
//  GetUserLocationVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 20/12/2021.
//

import UIKit

class GetUserLocationVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }
    
    @IBAction func confirmButtonDidPress(_ sender: UIButton) {
    }
}
