//
//  SideMenuVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 16/04/2022.
//

import UIKit

class SideMenuVC: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!

    fileprivate let cellName = "SideMenuCell"
    var direction: CATransitionSubtype!
    let titles = ["Personal information".localized(),"My addresses".localized(), "My orders".localized(),"Terms & conditions".localized(),"Language".localized(), "Log out".localized()]
    let images = ["info.circle", "location.circle", "takeoutbag.and.cup.and.straw", "newspaper","globe","rectangle.portrait.and.arrow.right"]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        if SharedData.SharedInstans.GetIsLogin() {
            welcomeLabel.text = "Hi".localized() + " " + SharedData.SharedInstans.getUserName()
        } else {
            welcomeLabel.text = "Hi Guest".localized()
        }


        // Do any additional setup after loading the view.
    }

    func registerXib() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }

    func changeLanguage() {
        let alert = UIAlertController(title: "Warning".localized(), message: "Do you want to change language?".localized(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localized(), style: .default) { action in
            LanguageManager.switchLanguage()
        }

        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        if LanguageManager.isArabic() {
            direction = .fromRight
        } else {
            direction = .fromLeft
        }
        self.dismissDetail(transitionSubtype: direction)
    }

}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? SideMenuCell else {return UITableViewCell()}
        cell.setupCell(itemImageName: images[indexPath.row], itemName: titles[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let personalInfoVC = ChangeUSerInfoVC.instantiate(fromAppStoryboard: .CheckOut)
            personalInfoVC.modalPresentationStyle = .fullScreen
            self.present(personalInfoVC, animated: true, completion: nil)
            break
        case 1:
            let selectAddressVc = SelectAddressVC.instantiate(fromAppStoryboard: .CheckOut)
            selectAddressVc.isFromSideMenu = true
            selectAddressVc.modalPresentationStyle = .fullScreen
            self.present(selectAddressVc, animated: true, completion: nil)

        case 2:
            let myOrders = MyOrdersVC.instantiate(fromAppStoryboard: .CheckOut)
            myOrders.modalPresentationStyle = .fullScreen
            self.present(myOrders, animated: true, completion: nil)
            break
        case 3:

            //LanguageManager.switchLanguage()
            break
        case 4:
            changeLanguage()
            break
        case 5:

            break
        default:
            break
        }
    }
}
