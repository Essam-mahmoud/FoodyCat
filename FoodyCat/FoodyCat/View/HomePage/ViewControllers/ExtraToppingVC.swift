//
//  ExtraToppingVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 16/12/2021.
//

import UIKit

class ExtraToppingVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var toppingTableView: ContentSizedTableView!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var cardView: CardWithShadow!
    @IBOutlet weak var cardItemCount: UILabel!
    @IBOutlet weak var cardTotalPrice: UILabel!
    
    var itemCounter = 1
    var extraToppingCellName = "ExtaToppingCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        topView.darkBlurView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeView))
        topView.addGestureRecognizer(tap)
        registerCell()
        getToppingData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }

    func registerCell() {
        toppingTableView.delegate = self
        toppingTableView.dataSource = self
        toppingTableView.register(UINib(nibName: extraToppingCellName, bundle: nil), forCellReuseIdentifier: extraToppingCellName)
    }

    func getToppingData() {

    }

    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func increaseCounterButtonDidPress(_ sender: UIButton) {
    }

    @IBAction func decreaseCounterButtonPress(_ sender: UIButton) {
    }

    @IBAction func addToCartButtonDidPress(_ sender: UIButton) {
    }
}

extension ExtraToppingVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Option" + " \(section)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: extraToppingCellName, for: indexPath) as? ExtaToppingCell else{return UITableViewCell()}
        return cell
    }
}
