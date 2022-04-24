//
//  VendorVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import UIKit
import Cosmos

class VendorVC: UIViewController {

    //MARK:- Outlets

    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorSpecialityLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var celebrityImage: UIImageView!
    @IBOutlet weak var celebrityNameLabel: UILabel!
    @IBOutlet weak var celibritySubtitleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var menuTableView: ContentSizedTableView!
    @IBOutlet weak var menuTableViewHightConstrains: NSLayoutConstraint!
    @IBOutlet weak var statusView: CardView!
    @IBOutlet weak var totalPriceCartLabel: UILabel!
    @IBOutlet weak var numberOfItemsInCardLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var openImageButton: UIButton!
    @IBOutlet weak var celebrityView: UIView!
    //MARK:- Properity
    var isComeFromHome = false
    var vendorImageURL = ""
    var celebrityImageURL = ""
    var celebrityName = ""
    var vendorNameLable = ""
    var vendorSpeciality = ""
    var vendorRating = 0
    var vendorId = 0
    var busy = false
    var open = false
    var celebrityId = 0
    var deliveryCharge = 0.0
    var vendorVM = VendorVM()
    var realmModel = LocalCartItemsVM()
    fileprivate let mealCellName = "MealsCell"
    fileprivate let tabCellName = "TabsCell"
    fileprivate let menuItemCellName = "MenuItemCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        realmModel.delegate = self
        realmModel.fetchItems()
        setupUI()
        getCelebritySuggetion()
        getMenuItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        realmModel.fetchItems()
        mainView.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }

    func setupUI() {
        openImageButton.setTitle("", for: .normal)
        vendorImage.loadImageFromUrl(imgUrl: vendorImageURL, defString: "")
        celebrityImage.loadImageFromUrl(imgUrl: celebrityImageURL, defString: "")
        celebrityNameLabel.text = celebrityName
        vendorNameLabel.text = vendorNameLable
        vendorSpecialityLabel.text = vendorSpeciality
        ratingView.rating = Double(vendorRating)
        ratingView.isUserInteractionEnabled = false
        registerCells()
        if isComeFromHome {
            celebrityView.isHidden = true
        }

        if !open {
            statusView.isHidden = false
            statusView.backgroundColor = UIColor.red
            statusLabel.text = "Closed".localized()
        } else {
            if busy {
                statusView.isHidden = false
                statusView.backgroundColor = UIColor.init(named: "mango")
                statusLabel.text = "Busy".localized()
            } else {
                statusView.isHidden = true
            }
        }
    }

    func registerCells() {
        mealsCollectionView.delegate = self
        mealsCollectionView.dataSource = self
        mealsCollectionView.register(UINib(nibName: mealCellName, bundle: nil), forCellWithReuseIdentifier: mealCellName)

        tabsCollectionView.delegate = self
        tabsCollectionView.dataSource = self
        tabsCollectionView.register(UINib(nibName: tabCellName, bundle: nil), forCellWithReuseIdentifier: tabCellName)

        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: menuItemCellName, bundle: nil), forCellReuseIdentifier: menuItemCellName)
    }

    func getCelebritySuggetion() {
        vendorVM.getRestaurantCelebritySuggestionData(vendorId: vendorId, celebrityId: celebrityId) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.mealsCollectionView.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.vendorVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func getMenuItems() {
        vendorVM.getRestaurantData(vendorId: vendorId) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.tabsCollectionView.reloadData()
                self.menuTableView.reloadData()
                self.tabsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.vendorVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func addSuggestionItems(index: IndexPath) {
        let vendorIdString = "\(vendorId)"
        if vendorIdString == SharedData.SharedInstans.getVendorId() || SharedData.SharedInstans.getVendorId() == "" {
            addSuggestion(index: index)
        } else {
            let alert = UIAlertController(title: "Warning", message: "Do you want to start new order ?".localized(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localized(), style: .default) { action in
                try! self.realmModel.realm.write {
                    self.realmModel.realm.deleteAll()
                }
                self.addSuggestion(index: index)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func addSuggestion(index: IndexPath) {
        guard let item = vendorVM.suggestionData?.data?[index.row] else {return}
        if item.hasExtraTopping ?? false{
            let toppingVC = ExtraToppingVC.instantiate(fromAppStoryboard: .Home)
            toppingVC.delegate = self
            toppingVC.vendorId = self.vendorId
            toppingVC.celebrityId = self.celebrityId
            toppingVC.deliveryCharge = self.deliveryCharge
            toppingVC.vendorName = self.vendorNameLable
            toppingVC.vendorImage = self.vendorImageURL
            toppingVC.item = item
            toppingVC.modalPresentationStyle = .overCurrentContext
            self.present(toppingVC, animated: true, completion: nil)
        } else {

            let descriptionVC = ItemDetailsVC.instantiate(fromAppStoryboard: .Home)
            descriptionVC.delegate = self
            descriptionVC.item = item
            descriptionVC.vendorId = self.vendorId
            descriptionVC.celebrityId = self.celebrityId
            descriptionVC.deliveryCharge = self.deliveryCharge
            descriptionVC.vendorName = self.vendorNameLable
            descriptionVC.vendorImage = self.vendorImageURL
            descriptionVC.modalPresentationStyle = .overCurrentContext
            self.present(descriptionVC, animated: true, completion: nil)
        }
    }

    func addItemTapped(index: IndexPath) {
        let vendorIdString = "\(vendorId)"
        if vendorIdString == SharedData.SharedInstans.getVendorId() || SharedData.SharedInstans.getVendorId() == "" {
            addItem(index: index)
        } else {
            let alert = UIAlertController(title: "Warning", message: "Do you want to start new order ?".localized(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localized(), style: .default) { action in
                try! self.realmModel.realm.write {
                    self.realmModel.realm.deleteAll()
                }
                self.addItem(index: index)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func addItem(index: IndexPath) {
        guard let item = vendorVM.itemsResult?.data?[index.section].items?[index.row] else {return}
        if item.hasExtraTopping ?? false{
            let toppingVC = ExtraToppingVC.instantiate(fromAppStoryboard: .Home)
            toppingVC.delegate = self
            toppingVC.vendorId = self.vendorId
            toppingVC.celebrityId = self.celebrityId
            toppingVC.deliveryCharge = self.deliveryCharge
            toppingVC.vendorName = self.vendorNameLable
            toppingVC.vendorImage = self.vendorImageURL
            toppingVC.item = item
            toppingVC.modalPresentationStyle = .overCurrentContext
            self.present(toppingVC, animated: true, completion: nil)
        } else {

            let descriptionVC = ItemDetailsVC.instantiate(fromAppStoryboard: .Home)
            descriptionVC.delegate = self
            descriptionVC.item = item
            descriptionVC.vendorId = self.vendorId
            descriptionVC.celebrityId = self.celebrityId
            descriptionVC.deliveryCharge = self.deliveryCharge
            descriptionVC.vendorName = self.vendorNameLable
            descriptionVC.vendorImage = self.vendorImageURL
            descriptionVC.modalPresentationStyle = .overCurrentContext
            self.present(descriptionVC, animated: true, completion: nil)
        }
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func openImageButtonDidPress(_ sender: UIButton) {
        let openFullImageVC = openImageVC.instantiate(fromAppStoryboard: .CheckOut)
        openFullImageVC.imageURL = vendorImageURL
        openFullImageVC.modalPresentationStyle = .fullScreen
        self.present(openFullImageVC, animated: true, completion: nil)
    }
    @IBAction func openCartDidPress(_ sender: UIButton) {
        let cartVc = CartVC.instantiate(fromAppStoryboard: .Home)
        cartVc.modalPresentationStyle = .fullScreen
        self.present(cartVc, animated: true, completion: nil)
    }
}

extension VendorVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2000 {
            return vendorVM.suggestionData?.data?.count ?? 0
        } else {
            return vendorVM.itemsResult?.data?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 2000 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealCellName, for: indexPath) as? MealsCell else {return UICollectionViewCell()}
            if let meal = vendorVM.suggestionData?.data?[indexPath.row] {
                cell.setupCell(data: meal)
            }
            cell.addTapped = {[weak self] selecteditem in
                self?.addSuggestionItems(index: indexPath)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCellName, for: indexPath) as? TabsCell else {return UICollectionViewCell()}
            if let mainItem = vendorVM.itemsResult?.data?[indexPath.item] {
                cell.setupCell(data: mainItem)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if collectionView.tag == 2000 {
            addSuggestionItems(index: indexPath)
        } else {
            menuTableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.item), at: .top, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2000 {
            return CGSize(width: 182, height: 300)
        } else {
            let item = vendorVM.itemsResult?.data?[indexPath.row].title ?? ""
            let itemSize = item.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
            ])
            return CGSize(width: itemSize.width + 30, height: 40)
        }
    }
}

extension VendorVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return vendorVM.itemsResult?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return vendorVM.itemsResult?.data?[section].title
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendorVM.itemsResult?.data?[section].items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: menuItemCellName, for: indexPath) as?  MenuItemCell else {return UITableViewCell()}
        if let item = vendorVM.itemsResult?.data?[indexPath.section].items?[indexPath.row] {
            cell.setupCell(data: item)
        }
        cell.addTapped = { [weak self] (selectedCell) in
            self?.addItemTapped(index: indexPath)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addItemTapped(index: indexPath)
    }
}

extension VendorVC: RealmViewModelDelegate {
    func recordFetch(items: [ItemOrderModel]) {
        var totalPrice = 0.0
        numberOfItemsInCardLabel.text = "\(items.count) " + "ITEM".localized()
        for item in items {
            totalPrice += item.itemtotalPrice
        }

        totalPriceCartLabel.text = String(format: "%.2f", totalPrice)
    }

    func recordSaved() {
        AppCommon.sharedInstance.showBanner(title: "Item Added".localized(), subtitle: "", style: .success)
    }
}

extension VendorVC: AddItemDelegate {
    func itemAdded() {
        realmModel.fetchItems()
    }
}

