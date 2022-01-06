//
//  SelectAddressVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 21/12/2021.
//

import UIKit

class SelectAddressVC: UIViewController {

    @IBOutlet weak var addressesTableView: UITableView!

    fileprivate let addressCellName = "AddressCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }

    func registerCells() {
        addressesTableView.delegate = self
        addressesTableView.dataSource = self
        addressesTableView.register(UINib(nibName: addressCellName, bundle: nil), forCellReuseIdentifier: addressCellName)
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
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: addressCellName, for: indexPath) as? AddressCell else {return UITableViewCell()}
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let paymentVc = PaymentMethodVC.instantiate(fromAppStoryboard: .CheckOut)
        paymentVc.modalPresentationStyle = .fullScreen
        self.present(paymentVc, animated: true, completion: nil)
    }
}
