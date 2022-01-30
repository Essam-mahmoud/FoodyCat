//
//  ThanksPageVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/01/2022.
//

import UIKit

class ThanksPageVC: UIViewController {

    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var orderTableView: ContentSizedTableView!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderAmountLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!

    var address: AddressData?
    var totalPrice = 0.0
    var orderNumber = 0
    var payment = ""
    var cartItems = [ItemOrderModel]()
    var realmModel = LocalCartItemsVM()
    let thankCellName = "thanksCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupUI()
        realmModel.delegate = self
        realmModel.fetchItems()
        // Do any additional setup after loading the view.
    }

    func registerCells(){
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.register(UINib(nibName: thankCellName, bundle: nil), forCellReuseIdentifier: thankCellName)
    }

    func setupUI() {
        addressName.text = address?.name
        addressLabel.text = address?.addressLineOne
        phoneLabel.text = address?.phone
        nameLabel.text = SharedData.SharedInstans.getUserName()
        orderNumberLabel.text = "\(orderNumber)"
        paymentLabel.text = payment
        vendorNameLabel.text = SharedData.SharedInstans.getVendorNAme()
        imageView.loadImageFromUrl(imgUrl: SharedData.SharedInstans.getVendorImage(), defString: "imageplaceholder")
    }
    
    @IBAction func backToHomeButtonDidPress(_ sender: UIButton) {
        try! self.realmModel.realm.write {
            self.realmModel.realm.deleteAll()
        }
        SharedData.SharedInstans.setDeliveryCharge(0)
        SharedData.SharedInstans.setVendorId("")
        guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootViewController else {return}
        UIApplication.shared.windows.first?.rootViewController = homeVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}

extension ThanksPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: thankCellName, for: indexPath) as? thanksCell else {return UITableViewCell()}
        cell.setupCell(data: cartItems[indexPath.row])
        return cell
    }
}

extension ThanksPageVC: RealmViewModelDelegate {
    func recordFetch(items: [ItemOrderModel]) {
        cartItems = items
        for item in items {
            totalPrice += item.itemtotalPrice
        }
        orderAmountLabel.text = "KWD".localized() + " \(totalPrice + SharedData.SharedInstans.getDeliveryCharge())"
        orderTableView.reloadData()
    }
}
