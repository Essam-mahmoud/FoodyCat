//
//  ShowOldAddressesVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 24/01/2022.
//

import UIKit

protocol ShowOldAddressesDelegate {
    func updateAddress()
}

class ShowOldAddressesVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addressesTableView: UITableView!
    @IBOutlet weak var openMapButton: UIButton!

    var delegate: ShowOldAddressesDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        openMapButton.setTitle("", for: .normal)
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
        delegate?.updateAddress()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openMapButtonDidPress(_ sender: UIButton) {
        let mapVc = GetUserLocationVC.instantiate(fromAppStoryboard: .Home)
        mapVc.isFromHomePage = true
        mapVc.modalPresentationStyle = .fullScreen
        self.present(mapVc, animated: true, completion: nil)
    }

}
