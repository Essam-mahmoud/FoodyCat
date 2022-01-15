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
    @IBOutlet weak var topTitleLabel: UILabel!

    var address: AddressData?
    var paymentsMethodVM = PaymentsMethodVM()
    var selectionArray = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupUI()
        getPaymentMethods()

    }

    func registerCell() {
        methodsTableView.delegate = self
        methodsTableView.dataSource = self
        methodsTableView.register(UINib(nibName: methodCellName, bundle: nil), forCellReuseIdentifier: methodCellName)
    }

    func setupUI() {
        topTitleLabel.text = address?.name
        addressLabel.text = address?.addressLineOne
        phoneLabel.text = ""
        nameLabel.text = ""
    }

    func getPaymentMethods() {
        paymentsMethodVM.getPaymentsMethods { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.methodsTableView.reloadData()
                self.fillArray()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.paymentsMethodVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func fillArray() {
        guard let methods = paymentsMethodVM.methods else {return}
        for _ in methods {
            selectionArray.append(false)
        }
    }

    func selectionchange(index: Int) {
        for i in 0..<selectionArray.count {
            selectionArray[i] = false
        }
        selectionArray[index] = true
        methodsTableView.reloadData()
    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension PaymentMethodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentsMethodVM.methods?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: methodCellName, for: indexPath) as? PaymentMethodsCell else {return UITableViewCell()}
        if let method = paymentsMethodVM.methods?[indexPath.row] {
            cell.setupCell(data: method, isSelected: selectionArray[indexPath.row])
        }

        cell.selectedTapped = {[weak self] selectedCell in
            self?.selectionchange(index: indexPath.row)
        }
        return cell
    }
}
