
import AKSideMenu
import Foundation
import UIKit

final class LeftMenuViewController: UIViewController {

    // MARK: - Life Cycle
    @IBOutlet weak var closeButton: UIButton!
    let titles = ["Personal information".localized(), "My addresses".localized(), "My orders".localized(), "Wallet".localized(), "Language".localized(), "Log out".localized()]
    let images = ["Support", "Setting", "terms", "FAQ", "lang","logoutMenu"]

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(closeButton)
        addTableView()
    }

    // MARK: - Private Methods

    private func addTableView() {
        let tableView = UITableView(frame: CGRect(x: 0,
                                                  y: (self.view.frame.size.height - 60 * 7) / 2.0,
                                                  width: self.view.frame.size.width,
                                                  height: 60 * 7), style: .plain)
        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isOpaque = false
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.separatorStyle = .none
        tableView.bounces = false

        view.addSubview(tableView)
    }

    @IBAction func closeButtonDidPress(_ sender: UIButton) {
        sideMenuViewController?.hideMenuViewController()
    }
}

extension LeftMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
//            let balanceVc = ShowBalanceDetailsVC.instantiate(fromAppStoryboard: .Payment)
//            balanceVc.modalPresentationStyle = .fullScreen
//            self.present(balanceVc, animated: true, completion: nil)
//            sideMenuViewController?.hideMenuViewController()
            break
        case 1:
            let selectAddressVc = SelectAddressVC.instantiate(fromAppStoryboard: .CheckOut)
            selectAddressVc.isFromSideMenu = true
            selectAddressVc.modalPresentationStyle = .fullScreen
            self.present(selectAddressVc, animated: true, completion: nil)
            sideMenuViewController?.hideMenuViewController()
            break
        case 2:
            let myOrders = MyOrdersVC.instantiate(fromAppStoryboard: .CheckOut)
            myOrders.modalPresentationStyle = .fullScreen
            self.present(myOrders, animated: true, completion: nil)
            sideMenuViewController?.hideMenuViewController()
            break
        case 3:
            LanguageManager.switchLanguage()
            break
        case 4:
//            let FAQView = ShowUrlsVC.instantiate(fromAppStoryboard: .Home)
//            FAQView.isTerms = false
//            self.present(FAQView, animated: true, completion: nil)
            break
        case 5:
//            LanguageManager.switchLanguage()
            break
        case 6:
//            LogoutVM.shared.logOut { (errMsg, errRes, status) in
//                switch status {
//                case .populated:
//                    SharedData.SharedInstans.SetIsLogin(false)
//                    guard let signin = UIStoryboard.init(name:"SignUp", bundle: nil).instantiateViewController(withIdentifier: "SigninVC") as? SigninVC else {return}
//                    UIApplication.shared.windows.first?.rootViewController = signin
//                    UIApplication.shared.windows.first?.makeKeyAndVisible()
//                case .error:
//                    AppCommon.sharedInstance.showBanner(title: "Something went wrong try agen later".localized(), subtitle: "", style: .danger)
//                default:
//                    break
//                }
//            }
        break
        default:
            break
        }
    }
}

extension LeftMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "Cell"

        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell?.backgroundColor = .clear
            cell?.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.highlightedTextColor = .lightGray
            cell?.selectedBackgroundView = UIView()
        }


        DispatchQueue.main.async {
            cell?.textLabel?.text = self.titles[indexPath.row]
            cell?.imageView?.image = UIImage(named: self.images[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
}
