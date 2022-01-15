//
//  CreateAccountVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 09/12/2021.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var dateOfBirthTF: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!

    var createAccountVM = CreateAccountVM()
    var isValidEmail = false
    var isValidPassWord = false
    var isValidPhone = false
    var cameFromOrder = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }

    func setup() {
        emailTF.addTarget(self, action: #selector(validatEmail(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(validatPass(_:)), for: .editingChanged)
        phoneNumberTF.addTarget(self, action: #selector(validatPhone(_:)), for: .editingChanged)
    }

    func createAccount(){
        guard let fullName = fullNameTF.text else {return}
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        guard let phone = phoneNumberTF.text  else {return}
        guard let dateOfBirth = dateOfBirthTF.text else {return}
        if fullName != "" && email != "" && password != "" && phone != "" {

            createAccountVM.register(phone: phone, email: email, name: fullName, password: password, datOfBirth: dateOfBirth) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    if self.cameFromOrder {
                        SharedData.SharedInstans.SetIsLogin(true)
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    } else {
                        SharedData.SharedInstans.SetIsLogin(true)
                        AppCommon.sharedInstance.showBanner(title: self.createAccountVM.result?.message ?? "", subtitle: "", style: .success, customColor: UIColor(named: "tealish"))
                        let homeVC = HomeVC.instantiate(fromAppStoryboard: .Home)
                        homeVC.modalPresentationStyle = .fullScreen
                        self.present(homeVC, animated: true, completion: nil)
                    }
                case .error:
                    AppCommon.sharedInstance.showBanner(title: self.createAccountVM.result?.message ?? "", subtitle: "", style: .danger)
                default:
                    break
                }
            }
        } else {
            AppCommon.sharedInstance.showBanner(title: "please fill required data to continue".localized(), subtitle: "", style: .danger)
        }
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func openMapDidPress(_ sender: UIButton) {
    }
    @IBAction func createDidPress(_ sender: UIButton) {
        createAccount()
    }


    @objc func validatEmail(_ textField: UITextField) {
        if AppCommon.sharedInstance.isValidEmail(txtString: self.emailTF.text ?? "") {
            isValidEmail = true
        }else{
            isValidEmail = false
        }
        changeButtonDesign()
    }
    @objc func validatPass(_ textField: UITextField) {
        if self.passwordTF.text?.count ?? 0 >= 4{
            isValidPassWord = true
        }else{
            isValidPassWord = false
        }
        changeButtonDesign()
    }

    @objc func validatPhone(_ textField: UITextField) {
        if AppCommon.sharedInstance.isValidEmail(txtString: self.phoneNumberTF.text ?? ""){
            isValidPhone = true
        }else{
            isValidPhone = false
        }
        changeButtonDesign()
    }
    func changeButtonDesign()  {
        if isValidData(){
            createAccountButton.isEnabled = true
            createAccountButton.setTitleColor(.white, for: .normal)
            createAccountButton.backgroundColor = UIColor.purple
        }else{
            createAccountButton.isEnabled = false
            createAccountButton.setTitleColor(#colorLiteral(red: 0.5607843137, green: 0.6078431373, blue: 0.7019607843, alpha: 1), for: .normal)
            createAccountButton.backgroundColor =  UIColor.systemGray4
        }
    }
    func isValidData() -> Bool {
        if self.isValidEmail && isValidPassWord && isValidPhone {
            return true
        }else{
            return false
        }
    }
}
