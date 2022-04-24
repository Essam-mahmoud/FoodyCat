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
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var discountStaticLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    var itemsCellName = "CartItemsCell"
    var totalPrice = 0.0
    var realmModel = LocalCartItemsVM()
    var cartItems = [ItemOrderModel]()
    var voucherVM = VoucherVM()
    var voucherAmount = 0.0
    var isFixed = false

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
        serviceChageLabel.text = "KWD".localized() + " " + String(format: "%.2f", SharedData.SharedInstans.getDeliveryCharge())
        totalAmountLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice + SharedData.SharedInstans.getDeliveryCharge())
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

    func changeTotalPrice() {
        guard let result = voucherVM.result else {return}
        voucherAmount = result.amount ?? 0.0
        isFixed = result.fixedAmount ?? false
        SharedData.SharedInstans.setVoucherAmount(voucherAmount)
        SharedData.SharedInstans.setIsFixedAmount(isFixed)
        if voucherAmount > 0 {
            self.discountStaticLabel.isHidden = false
            self.discountLabel.isHidden = false
            if isFixed {
                totalAmountLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice + SharedData.SharedInstans.getDeliveryCharge() - voucherAmount)
                discountLabel.text = "KWD".localized() + " " + String(format: "%.2f", voucherAmount)
            } else {
                let discount = 1 - (voucherAmount / 100)
                totalAmountLabel.text = "KWD".localized() + " " + String(format: "%.2f", (totalPrice + SharedData.SharedInstans.getDeliveryCharge()) * discount)
                discountLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice * voucherAmount / 100)
            }
        } else {
            totalAmountLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice + SharedData.SharedInstans.getDeliveryCharge())
        }
    }

    @IBAction func addItemsButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func checkOutButtonDidPress(_ sender: UIButton) {
        if SharedData.SharedInstans.GetIsLogin() {
            let selectAddressVc = SelectAddressVC.instantiate(fromAppStoryboard: .CheckOut)
            selectAddressVc.modalPresentationStyle = .fullScreen
            self.present(selectAddressVc, animated: true, completion: nil)
        } else {
            let loginVC = SignInVC.instantiate(fromAppStoryboard: .Auth)
            loginVC.cameFromOrder = true
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }

    @IBAction func addVoucherButtonDidPress(_ sender: UIButton) {
        guard let voucher = voucherTF.text?.trimmingCharacters(in: .whitespaces) else {return}
        if voucher != "" {
            let vendorId = SharedData.SharedInstans.getVendorId()
            voucherVM.getDiscount(vendorId: vendorId, code: voucher) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    self.changeTotalPrice()
                    AppCommon.sharedInstance.showBanner(title: "Voucher Added".localized(), subtitle: "", style: .danger)
                    SharedData.SharedInstans.setCoupon(voucher)
                case .error:
                    AppCommon.sharedInstance.showBanner(title: self.voucherVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
                    break
                default:
                    break
                }
            }
        } else {
            AppCommon.sharedInstance.showBanner(title: "You must write code to apply".localized(), subtitle: "", style: .danger)
        }
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
        if cartItems.count > 0 {
            checkOutButton.isEnabled = true
        } else {
            checkOutButton.isEnabled = false
        }
        itemsTableView.reloadData()
        setupUI()
    }

    func recordDeleted() {
        getCartItems()
    }
}
