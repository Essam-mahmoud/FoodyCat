//
//  ForgetPasswordVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 09/12/2021.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!

    var forgetPasswordVM = ForgetPasswordVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func nextButtonDidPress(_ sender: UIButton) {
        guard let phone = emailTF.text else {return}
        if AppCommon.sharedInstance.isValidEmail(txtString: phone) {
            forgetPasswordVM.forgetPassword(phone: phone) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    AppCommon.sharedInstance.showBanner(title: self.forgetPasswordVM.result?.data ?? "", subtitle: "", style: .success, customColor: UIColor(named: "tealish"))
                    self.dismiss(animated: true, completion: nil)
                case .error:
                    AppCommon.sharedInstance.showBanner(title: self.forgetPasswordVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
                default:
                    break
                }

            }
        } else {

        }
    }
}
