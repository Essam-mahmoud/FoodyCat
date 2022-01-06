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

    func addAddress() -> Bool{
        guard let area = areaTF.text else {return false}
        guard let block = blockTF.text else {return false}
        guard let street = streetTF.text else {return false}
        guard let buildingNo = buildingNoTF.text else {return false}
        guard let floor = floorTF.text else {return false}
        guard let apartmentNo = apartmentNoTF.text else {return false}
        guard let additionalInfo = additionDirectionsTV.text else {return false}

        if area != "" && block != "" && street != "" && buildingNo != "" && floor != "" && apartmentNo != "" {

        } else {
            return false
        }
        return true
    }

    @IBAction func completeButtonDidPress(_ sender: UIButton) {
        if addAddress() {
            let paymentVc = PaymentMethodVC.instantiate(fromAppStoryboard: .CheckOut)
            paymentVc.modalPresentationStyle = .fullScreen
            self.present(paymentVc, animated: true, completion: nil)
        } else {
            AppCommon.sharedInstance.showBanner(title: "Please fill all Data to continue...".localized(), subtitle: "", style: .danger)
        }
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
