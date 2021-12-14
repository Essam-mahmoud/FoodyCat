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
        guard let email = emailTF.text else {return}
        if AppCommon.sharedInstance.isValidEmail(txtString: email) {
            forgetPasswordVM.forgetPassword(email: email) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    SharedData.SharedInstans.SetIsLogin(true)
                    AppCommon.sharedInstance.showBanner(title: "New password send to your email".localized(), subtitle: "", style: .success, customColor: UIColor(named: "tealish"))
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
