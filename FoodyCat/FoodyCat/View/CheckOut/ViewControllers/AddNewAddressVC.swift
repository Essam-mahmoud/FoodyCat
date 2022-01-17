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
    @IBOutlet weak var phoneNumberTF: UITextField!

    var addressesVM = AddressesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areaTF.text = SharedData.SharedInstans.getAreaId()
        areaTF.isEnabled = false
        areaTF.textColor = UIColor.lightGray
    }

    func addAddress(){
        guard let area = areaTF.text else {return}
        guard let block = blockTF.text else {return}
        guard let street = streetTF.text else {return}
        guard let buildingNo = buildingNoTF.text else {return}
        guard let floor = floorTF.text else {return}
        guard let apartmentNo = apartmentNoTF.text else {return}
        guard let phone = phoneNumberTF.text else {return}
        guard let additionalInfo = additionDirectionsTV.text else {return}

        if area != "" && block != "" && street != "" && buildingNo != "" {
            let address = "Block " + block + ", " + street + " Street, " + buildingNo + ", " + floor + ", " + apartmentNo
            addressesVM.addAddress(address: address, extaInfo: additionalInfo, phone: phone) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    let paymentVc = PaymentMethodVC.instantiate(fromAppStoryboard: .CheckOut)
                    paymentVc.address = self.addressesVM.addAddressResult
                    paymentVc.modalPresentationStyle = .fullScreen
                    self.present(paymentVc, animated: true, completion: nil)
                case .error:
                    AppCommon.sharedInstance.showBanner(title: self.addressesVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
                default:
                    break
                }
            }
        } else {
            AppCommon.sharedInstance.showBanner(title: "Please fill all Data to continue...".localized(), subtitle: "", style: .danger)
        }
    }

    @IBAction func completeButtonDidPress(_ sender: UIButton) {
        addAddress()
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
