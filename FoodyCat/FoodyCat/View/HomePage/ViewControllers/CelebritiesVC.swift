//
//  CelebritiesVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import UIKit

class CelebritiesVC: UIViewController {

    @IBOutlet weak var celebrityImage: UIImageView!
    @IBOutlet weak var celibrityNameLabel: UILabel!
    @IBOutlet weak var resturantTableView: ContentSizedTableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var priceCartLabel: UILabel!
    @IBOutlet weak var numberOfItemsInCartLabel: UILabel!
    
    fileprivate let restaurantCellName = "RestaurantCell"
    var celebrityId = 0
    var celebrityName = ""
    var celebrityImageURL = ""
    var celebritiesRestaurantVM = CelebritiesRestaurantVM()
    var realmModel = LocalCartItemsVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        realmModel.delegate = self
        realmModel.fetchItems()
        setupUI()
        getRestaurants()
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
        resturantTableView.delegate = self
        resturantTableView.dataSource = self
        resturantTableView.register(UINib(nibName: restaurantCellName, bundle: nil), forCellReuseIdentifier: restaurantCellName)

        celebrityImage.loadImageFromUrl(imgUrl: celebrityImageURL, defString: "avatarPlaceHolder")
        celibrityNameLabel.text = celebrityName
    }

    func getRestaurants() {
        celebritiesRestaurantVM.getRestaurantData(id: celebrityId) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.resturantTableView.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.celebritiesRestaurantVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }
    
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func openCartDidPress(_ sender: UIButton) {
        let cartVc = CartVC.instantiate(fromAppStoryboard: .Home)
        cartVc.modalPresentationStyle = .fullScreen
        self.present(cartVc, animated: true, completion: nil)
    }
}

extension CelebritiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celebritiesRestaurantVM.vendors?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: restaurantCellName, for: indexPath) as? RestaurantCell else {return UITableViewCell()}
        if let vendor = celebritiesRestaurantVM.vendors?.data?[indexPath.row] {
            cell.setupCell(data: vendor)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vendor = celebritiesRestaurantVM.vendors?.data?[indexPath.row] {
            let vendorVc = VendorVC.instantiate(fromAppStoryboard: .Home)
            vendorVc.celebrityImageURL = self.celebrityImageURL
            vendorVc.celebrityName = self.celebrityName
            vendorVc.vendorImageURL = vendor.logo ?? ""
            vendorVc.vendorSpeciality = vendor.cuisines ?? ""
            vendorVc.vendorNameLable = vendor.name ?? ""
            vendorVc.vendorRating = vendor.rating ?? 0
            vendorVc.modalPresentationStyle = .fullScreen
            self.present(vendorVc, animated: true, completion: nil)
        }
    }
}

extension CelebritiesVC: RealmViewModelDelegate {
    func recordFetch(items: [ItemOrderModel]) {
        var totalPrice = 0.0
        numberOfItemsInCartLabel.text = "\(items.count) " + "ITEM".localized()
        for item in items {
            totalPrice += item.itemtotalPrice
        }

        priceCartLabel.text = String(format: "%.2f", totalPrice)
    }
}
