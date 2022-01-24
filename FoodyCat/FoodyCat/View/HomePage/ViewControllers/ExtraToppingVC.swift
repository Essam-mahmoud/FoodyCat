//
//  ExtraToppingVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 16/12/2021.
//

import UIKit
import RealmSwift

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
    var totalPrice = 0.0
    var numberOfExtraTopping = 0
    var extraToppingCellName = "ExtaToppingCell"
    var extraToppingVM = ExtraToppingVM()
    var delegate: AddItemDelegate?
    var item: Item?
    var vendorId = 0
    var celebrityId = 0
    var deliveryCharge = 0.0
    var vendorImage = ""
    var vendorName = ""
    var realmModel = LocalCartItemsVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        realmModel.delegate = self
        realmModel.fetchItems()
        topView.darkBlurView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeView))
        topView.addGestureRecognizer(tap)
        setupUI()
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

    func setupUI() {
        itemImage.loadImageFromUrl(imgUrl: item?.imgFullPath, defString: "imageplaceholder")
        itemNameLabel.text = item?.name
        itemDescriptionLabel.text = item?.itemDescription
        itemPriceLabel.text = "KWD".localized() + " \(item?.price ?? 0)"
        totalPrice = item?.price ?? 0.0
    }

    func registerCell() {
        toppingTableView.delegate = self
        toppingTableView.dataSource = self
        toppingTableView.register(UINib(nibName: extraToppingCellName, bundle: nil), forCellReuseIdentifier: extraToppingCellName)
    }

    func getToppingData() {
        extraToppingVM.getExtraToopingData(itemId: 34886) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.toppingTableView.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.extraToppingVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func selectionChange(index: IndexPath) {
        guard let maxQuantity = extraToppingVM.extraData?.data?[index.section].maxQty else {return}
        if let items  = extraToppingVM.extraData?.data?[index.section].items{
            if maxQuantity == 1 {
                for item in items {
                    item.isSelected = false
                }
                extraToppingVM.extraData?.data?[index.section].items?[index.row].isSelected = true
                totalPrice += Double(extraToppingVM.extraData?.data?[index.section].items?[index.row].price ?? 0)
            } else {
                if numberOfExtraTopping <= maxQuantity {
                    if let item = extraToppingVM.extraData?.data?[index.section].items?[index.row] {
                        if item.isSelected ?? false {
                            extraToppingVM.extraData?.data?[index.section].items?[index.row].isSelected = false
                        } else {
                            extraToppingVM.extraData?.data?[index.section].items?[index.row].isSelected = true
                            numberOfExtraTopping += 1
                        }
                    }
                } else {
                    AppCommon.sharedInstance.showBanner(title: "you need to select only" + " \(maxQuantity) " + "topping", subtitle: "", style: .danger)
                }
            }
        }
        toppingTableView.reloadData()
    }

    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func increaseCounterButtonDidPress(_ sender: UIButton) {
        itemCounter += 1
        totalPrice += item?.price ?? 0.0
        countLabel.text = "\(itemCounter)"
        itemPriceLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice)
        countLabel.layer.bottomAnimation(duration: 0.5)
    }

    @IBAction func decreaseCounterButtonPress(_ sender: UIButton) {
        if itemCounter > 1 {
            itemCounter -= 1
            totalPrice -= item?.price ?? 0.0
            countLabel.text = "\(itemCounter)"
            itemPriceLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice)
            countLabel.layer.topAnimation(duration: 0.5)
        }
    }

    @IBAction func addToCartButtonDidPress(_ sender: UIButton) {
        addToCart()
        delegate?.itemAdded()
        self.dismiss(animated: true, completion: nil)
    }

    func addToCart() {
        let cartItem = ItemOrderModel()
        let topping = RealmSwift.List<ItemTopping>()
        if let extraTopping = extraToppingVM.extraData?.data {
            for extraItem in extraTopping {
                if let items = extraItem.items {
                    for item in items {
                        if item.isSelected ?? false {
                            let tempTopping = ItemTopping()
                            tempTopping.toppingId = item.id ?? 0
                            tempTopping.toppingPrice = item.price ?? 0
                            topping.append(tempTopping)
                        }
                    }
                }
            }
        }
        cartItem.Id = item?.id ?? 0
        cartItem.itemDescription = item?.itemDescription ?? ""
        cartItem.itemImageURL = item?.imgFullPath ?? ""
        cartItem.itemName = item?.name ?? ""
        cartItem.itemNote = noteTextView.text
        cartItem.quantity = itemCounter
        cartItem.itemPrice = item?.price ?? 0.0
        cartItem.itemtotalPrice = totalPrice
        cartItem.topping = topping
        realmModel.saveItem(item: cartItem)
        SharedData.SharedInstans.setVendorName(vendorName)
        SharedData.SharedInstans.setVendorImage(vendorImage)
        SharedData.SharedInstans.setCelebrityId(celebrityId)
        SharedData.SharedInstans.setDeliveryCharge(deliveryCharge)
        SharedData.SharedInstans.setVendorId("\(vendorId)")
    }
}

extension ExtraToppingVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return extraToppingVM.extraData?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return extraToppingVM.extraData?.data?[section].title
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extraToppingVM.extraData?.data?[section].items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: extraToppingCellName, for: indexPath) as? ExtaToppingCell else{return UITableViewCell()}
        if let item  = extraToppingVM.extraData?.data?[indexPath.section].items?[indexPath.row] {
            cell.setupCell(data: item)
        }
        cell.selectedTapped = { [weak self] (selectCell) in
            self?.selectionChange(index: indexPath)
        }
        return cell
    }
}

extension ExtraToppingVC: RealmViewModelDelegate {
    func recordSaved() {
        AppCommon.sharedInstance.showBanner(title: "Item added".localized(), subtitle: "", style: .success)
    }

    func recordFetch(items: [ItemOrderModel]) {
        var totalPrice = 0.0
        cardItemCount.text = "\(items.count) " + "ITEM".localized()
        for item in items {
            totalPrice += item.itemtotalPrice
        }
        cardTotalPrice.text = String(format: "%.2f", totalPrice)
    }
}
