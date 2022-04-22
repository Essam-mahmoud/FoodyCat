//
//  ChangePasswordVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/04/2022.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!

    var changePasswordVM = ChangePasswordVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func confirmButtonDidPress(_ sender: UIButton) {
        guard let oldPass = oldPasswordTF.text else {return}
        guard let newPass = newPasswordTF.text else {return}
        guard let confirmPass = confirmPasswordTF.text else {return}
        if oldPass != "" && newPass != "" && confirmPass != "" {
            if newPass.count > 3 {
                if newPass == confirmPass {
                    changePasswordVM.changeUserPassword(newPass: newPass, OldPass: oldPass) { (errMsg, errRes, status) in
                        switch status {
                        case .populated:
                            AppCommon.sharedInstance.showBanner(title: self.changePasswordVM.result?.message ?? "", subtitle: "", style: .danger)
                        case .error:
                            AppCommon.sharedInstance.showBanner(title: self.changePasswordVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
                        default:
                            break
                        }
                    }
                } else {
                    AppCommon.sharedInstance.showBanner(title: "Password dosn't match".localized(), subtitle: "", style: .danger)
                }
            } else {
                AppCommon.sharedInstance.showBanner(title: "Password must be more than 3 characters".localized(), subtitle: "", style: .danger)
            }

        } else  {
            AppCommon.sharedInstance.showBanner(title: "Please fill all Data to continue...".localized(), subtitle: "", style: .danger)
        }
    }
}
