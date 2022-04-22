//
//  ChangeUSerInfoVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 01/02/2022.
//

import UIKit

class ChangeUSerInfoVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var userDataVM = UserDataVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }

    func loadUserData() {
        userDataVM.getUserInfo { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.updateUI()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.userDataVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func updateUI() {
        guard let user = userDataVM.data?.data?.user else {return}
        let firstName = user.fName ?? ""
        let lastName = user.lName ?? ""
        nameTF.text =  firstName + lastName
        emailTF.text = user.email
        phoneTF.text = user.phone
        passwordTF.text = "123456"
        passwordTF.isEnabled = false
        phoneTF.isEnabled = false
    }

    @IBAction func updateButtonDidPress(_ sender: UIButton) {
        guard let name = nameTF.text else {return}
        guard let email = emailTF.text else {return}

        if name != "" && email != "" {
            userDataVM.updateUserInfo(name: name, email: email) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    AppCommon.sharedInstance.showBanner(title: self.userDataVM.result?.message ?? "", subtitle: "", style: .danger)
                case .error:
                    AppCommon.sharedInstance.showBanner(title: self.userDataVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
                default:
                    break
                }
            }
        } else {
            AppCommon.sharedInstance.showBanner(title: "Please fill all Data to continue...".localized(), subtitle: "", style: .danger)
        }
    }
    
    @IBAction func changePasswordButtonDidPress(_ sender: UIButton) {
        let changePassVC = ChangePasswordVC.instantiate(fromAppStoryboard: .CheckOut)
        changePassVC.modalPresentationStyle = .fullScreen
        self.present(changePassVC, animated: true, completion: nil)
    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
