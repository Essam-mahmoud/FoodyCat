//
//  CartVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 18/12/2021.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var voucherTF: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var serviceChageLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!

    var itemsCellName = "CartItemsCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }

    func registerCell() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.register(UINib(nibName: itemsCellName, bundle: nil), forCellReuseIdentifier: itemsCellName)
    }

    @IBAction func addItemsButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func checkOutButtonDidPress(_ sender: UIButton) {
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemsCellName, for: indexPath) as? CartItemsCell else {return UITableViewCell()}
        return cell
    }
}
