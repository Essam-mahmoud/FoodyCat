//
//  CartVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/12/2021.
//

import UIKit
import RealmSwift

class CartVC: UIViewController {

    @IBOutlet weak var itemsTableView: ContentSizedTableView!
    @IBOutlet weak var voucherTF: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var serviceChageLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!

    var itemsCellName = "CartItemsCell"
    var totalPrice = 0.0
    var delveryFees = 1.5
    var realmModel = LocalCartItemsVM()
    var cartItems = [ItemOrderModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        realmModel.delegate = self
        getCartItems()
    }

    func registerCell() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.register(UINib(nibName: itemsCellName, bundle: nil), forCellReuseIdentifier: itemsCellName)
    }

    func getCartItems() {
        realmModel.fetchItems()
    }

    func setupUI() {
        totalPrice = 0.0
        for item in cartItems {
            totalPrice += item.itemtotalPrice
        }
        subTotalLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice)
        serviceChageLabel.text = "KWD".localized() + " " + String(format: "%.2f", delveryFees)
        totalAmountLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice + delveryFees)
    }

    func increaseCounter(index: Int) {
        realmModel.realm.beginWrite()
        cartItems[index].quantity += 1
        cartItems[index].itemtotalPrice += cartItems[index].itemPrice
        try! realmModel.realm.commitWrite()
        setupUI()
        itemsTableView.reloadData()

    }

    func decreaseCounter(index: Int) {
        if cartItems[index].quantity > 1 {
            realmModel.realm.beginWrite()
            cartItems[index].quantity -= 1
            cartItems[index].itemtotalPrice -= cartItems[index].itemPrice
            try! realmModel.realm.commitWrite()
            setupUI()
            itemsTableView.reloadData()
        }
    }

    func deleteitem(index: Int) {
        realmModel.deleteItem(item: cartItems[index])
    }

    @IBAction func addItemsButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func checkOutButtonDidPress(_ sender: UIButton) {
        let selectAddressVc = SelectAddressVC.instantiate(fromAppStoryboard: .CheckOut)
        selectAddressVc.modalPresentationStyle = .fullScreen
        self.present(selectAddressVc, animated: true, completion: nil)
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemsCellName, for: indexPath) as? CartItemsCell else {return UITableViewCell()}
        cell.setupCell(data: cartItems[indexPath.row])
        cell.increaseTapped = { [weak self] (selectedCell) in
            self?.increaseCounter(index: indexPath.row)
        }

        cell.decreaseTapped = { [weak self] (selectedCell) in
            self?.decreaseCounter(index: indexPath.row)
        }

        cell.deleteTapped = { [weak self] (selectedCell) in
            self?.deleteitem(index: indexPath.row)
        }

        return cell
    }
}


extension CartVC: RealmViewModelDelegate {
    func recordFetch(items: [ItemOrderModel]) {
        cartItems = items
        itemsTableView.reloadData()
        setupUI()
    }

    func recordDeleted() {
        getCartItems()
    }
}
