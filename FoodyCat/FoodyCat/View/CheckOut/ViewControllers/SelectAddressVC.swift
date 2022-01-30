//
//  SelectAddressVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/12/2021.
//

import UIKit
import SwiftUI

class SelectAddressVC: UIViewController {

    @IBOutlet weak var addressesTableView: UITableView!

    @IBOutlet weak var noAddressLabel: UILabel!
    fileprivate let addressCellName = "AddressCell"
    var getAddressesVM = AddressesVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        getAddresses()
    }

    func registerCells() {
        addressesTableView.delegate = self
        addressesTableView.dataSource = self
        addressesTableView.register(UINib(nibName: addressCellName, bundle: nil), forCellReuseIdentifier: addressCellName)
    }

    func getAddresses() {
        getAddressesVM.getAddresses(page: 1) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                if self.getAddressesVM.addressesResult?.data?.count ?? 0 > 0 {
                    self.noAddressLabel.isHidden = true
                } else {
                    self.noAddressLabel.isHidden = false
                }
                self.addressesTableView.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.getAddressesVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func addNewAddressButtonDidPress(_ sender: UIButton) {
        let addVC = AddNewAddressVC.instantiate(fromAppStoryboard: .CheckOut)
        addVC.modalPresentationStyle = .fullScreen
        self.present(addVC, animated: true, completion: nil)
    }
}

extension SelectAddressVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAddressesVM.addressesResult?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: addressCellName, for: indexPath) as? AddressCell else {return UITableViewCell()}
        if let address = getAddressesVM.addressesResult?.data?[indexPath.row] {
            cell.setupCell(data: address)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let paymentVc = PaymentMethodVC.instantiate(fromAppStoryboard: .CheckOut)
        if let address = getAddressesVM.addressesResult?.data?[indexPath.row] {
            paymentVc.address = address
            paymentVc.modalPresentationStyle = .fullScreen
            self.present(paymentVc, animated: true, completion: nil)
        }
    }
}
