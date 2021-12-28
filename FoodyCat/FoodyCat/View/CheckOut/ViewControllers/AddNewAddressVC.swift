//
//  AddNewAddressVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 22/12/2021.
//

import UIKit

class AddNewAddressVC: UIViewController {

    @IBOutlet weak var areaTF: UITextField!
    @IBOutlet weak var blockTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var buildingNoTF: UITextField!
    @IBOutlet weak var floorTF: UITextField!
    @IBOutlet weak var apartmentNoTF: UITextField!
    @IBOutlet weak var additionDirectionsTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func completeButtonDidPress(_ sender: UIButton) {
        let paymentVc = PaymentMethodVC.instantiate(fromAppStoryboard: .CheckOut)
        paymentVc.modalPresentationStyle = .fullScreen
        self.present(paymentVc, animated: true, completion: nil)
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
