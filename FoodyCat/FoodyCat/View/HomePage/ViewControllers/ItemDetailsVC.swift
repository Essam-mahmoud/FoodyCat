//
//  ItemDetailsVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 24/01/2022.
//

import UIKit

protocol AddItemDelegate {
    func itemAdded()
}

class ItemDetailsVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var noteTV: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numberOfItemsInCartLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    var realmModel = LocalCartItemsVM()
    var delegate: AddItemDelegate?
    var item: Item?
    var vendorId = 0
    var itemCounter = 1
    var totalPrice = 0.0
    var celebrityId = 0
    var deliveryCharge = 0.0
    var vendorImage = ""
    var vendorName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        topView.darkBlurView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        topView.addGestureRecognizer(tap)
        realmModel.delegate = self
        realmModel.fetchItems()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }

    func setupView() {
        itemImage.loadImageFromUrl(imgUrl: item?.imgFullPath, defString: "imageplaceholder")
        itemImage.layer.cornerRadius = 15
       // self.itemImage.roundCorners([.topLeft, .topRight], radius: 15)
        closeButton.setTitle("", for: .normal)
        itemNameLabel.text = item?.name
        itemDescriptionLabel.text = item?.itemDescription
        priceLabel.text = "KWD".localized() + " \(item?.price ?? 0)"
        totalPrice = item?.price ?? 0.0
        
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decreaseButtonDidPress(_ sender: UIButton) {
        if itemCounter > 1 {
            itemCounter -= 1
            totalPrice -= item?.price ?? 0.0
            counterLabel.text = "\(itemCounter)"
            priceLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice)
            counterLabel.layer.topAnimation(duration: 0.5)
        }
    }

    @IBAction func increaseButtonDidPress(_ sender: UIButton) {
        itemCounter += 1
        totalPrice += item?.price ?? 0.0
        counterLabel.text = "\(itemCounter)"
        priceLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice)
        counterLabel.layer.bottomAnimation(duration: 0.5)
    }
    
    @IBAction func addToCardButtonDidPress(_ sender: UIButton) {
        guard let note = noteTV.text else {return}
        let cartItem = ItemOrderModel()
        cartItem.Id = item?.id ?? 0
        cartItem.itemDescription = item?.itemDescription ?? ""
        cartItem.itemImageURL = item?.imgFullPath ?? ""
        cartItem.itemName = item?.name ?? ""
        cartItem.quantity = itemCounter
        cartItem.itemPrice = item?.price ?? 0.0
        cartItem.itemtotalPrice = totalPrice
        cartItem.itemNote = note
        realmModel.saveItem(item: cartItem)
        realmModel.fetchItems()
        SharedData.SharedInstans.setVendorName(vendorName)
        SharedData.SharedInstans.setVendorImage(vendorImage)
        SharedData.SharedInstans.setCelebrityId(celebrityId)
        SharedData.SharedInstans.setDeliveryCharge(deliveryCharge)
        SharedData.SharedInstans.setVendorId("\(vendorId)")
        delegate?.itemAdded()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func closeButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension ItemDetailsVC: RealmViewModelDelegate {
    func recordSaved() {
        AppCommon.sharedInstance.showBanner(title: "Item added".localized(), subtitle: "", style: .success)
    }

    func recordFetch(items: [ItemOrderModel]) {
        var totalPrice = 0.0
        numberOfItemsInCartLabel.text = "\(items.count) " + "ITEM".localized()
        for item in items {
            totalPrice += item.itemtotalPrice
        }
        totalPriceLabel.text = String(format: "%.2f", totalPrice)
    }
}
