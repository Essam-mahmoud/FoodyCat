//
//  ShowOldAddressesVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 24/01/2022.
//

import UIKit

class ShowOldAddressesVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addressesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.darkBlurView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        topView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }

}
