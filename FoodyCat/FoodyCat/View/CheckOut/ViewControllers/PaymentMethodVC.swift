//
//  PaymentMethodVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 22/12/2021.
//

import UIKit

class PaymentMethodVC: UIViewController {

    fileprivate let methodCellName = "PaymentMethodsCell"
    @IBOutlet weak var methodsTableView: ContentSizedTableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var serviceChargeLAbel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }

    func registerCell() {
        methodsTableView.delegate = self
        methodsTableView.dataSource = self
        methodsTableView.register(UINib(nibName: methodCellName, bundle: nil), forCellReuseIdentifier: methodCellName)
    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension PaymentMethodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: methodCellName, for: indexPath) as? PaymentMethodsCell else {return UITableViewCell()}
        return cell
    }
}
