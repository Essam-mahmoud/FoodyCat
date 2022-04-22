//
//  SignInVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 09/12/2021.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var signInVM = SignInVM()
    var isValidEmail = false
    var isValidPassWord = false
    var cameFromOrder = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }

    func setup() {
        userNameTF.addTarget(self, action: #selector(validatEmail(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(validatPass(_:)), for: .editingChanged)
    }

    @IBAction func forgetPasswordDidPress(_ sender: UIButton) {
        let forgetPassVC = ForgetPasswordVC.instantiate(fromAppStoryboard: .Auth)
        forgetPassVC.modalPresentationStyle = .fullScreen
        self.present(forgetPassVC, animated: true, completion: nil)

    }
    @IBAction func signInDidPress(_ sender: UIButton) {
        guard let phoneNumber = userNameTF.text else {return}
        guard let password = passwordTF.text else {return}
        signInVM.UserLogin(phone: phoneNumber, password: password) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                if self.cameFromOrder {
                    SharedData.SharedInstans.SetIsLogin(true)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    SharedData.SharedInstans.SetIsLogin(true)
                    AppCommon.sharedInstance.showBanner(title: "Logged in Successfully".localized(), subtitle: "", style: .success, customColor: UIColor(named: "tealish"))
                    let homeVC = HomeVC.instantiate(fromAppStoryboard: .Home)
                    homeVC.modalPresentationStyle = .fullScreen
                    self.present(homeVC, animated: true, completion: nil)
                }
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.signInVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }
    @IBAction func signUpDidPress(_ sender: UIButton) {
        let createAccountVC = CreateAccountVC.instantiate(fromAppStoryboard: .Auth)
        createAccountVC.cameFromOrder = cameFromOrder
        createAccountVC.modalPresentationStyle = .fullScreen
        self.present(createAccountVC, animated: true, completion: nil)
    }
    @IBAction func showPasswordDidPress(_ sender: UIButton) {
        passwordTF!.isSecureTextEntry = !passwordTF!.isSecureTextEntry
        if passwordTF!.isSecureTextEntry  {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }else {
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }

    @objc func validatEmail(_ textField: UITextField) {

        if AppCommon.sharedInstance.isValidEmail(txtString: self.userNameTF.text ?? "") {
            isValidEmail = true
        }else{
            isValidEmail = false
        }
        changeButtonDesign()

    }
    @objc func validatPass(_ textField: UITextField) {
        if  self.passwordTF.text?.count ?? 0 >= 3{
            isValidPassWord = true
        }else{
            isValidPassWord = false
        }
        changeButtonDesign()
    }
    func changeButtonDesign()  {
        if isValidData(){
            loginButton.isEnabled = true
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.backgroundColor = UIColor.purple
        }else{
            loginButton.isEnabled = false
            loginButton.setTitleColor(#colorLiteral(red: 0.5607843137, green: 0.6078431373, blue: 0.7019607843, alpha: 1), for: .normal)
            loginButton.backgroundColor =  UIColor.systemGray4
        }
    }
    func isValidData() -> Bool {
        if self.isValidEmail && isValidPassWord  {
            return true
        }else{
            return false
        }
    }
}
