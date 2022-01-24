//
//  HomeVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 09/12/2021.
//

import UIKit
import FSPagerView

class HomeVC: UIViewController {

    //MARK:- Outlets

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var deliverToLabel: UILabel!
    @IBOutlet weak var sideMenueButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var inProgressOrderView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var inProgressImage: UIImageView!
    @IBOutlet weak var celebritiesCollectionView: UICollectionView!
    @IBOutlet weak var totalCartPriceLabel: UILabel!
    @IBOutlet weak var numberOfItemsInCartLabel: UILabel!
    @IBOutlet weak var changeAddressButton: UIButton!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
            self.pagerView.automaticSlidingInterval = .init(3)
            self.pagerView.layer.cornerRadius = 15
            self.pagerView.clipsToBounds = true

        }
    }
    @IBOutlet weak var pagerControl: FSPageControl! {
        didSet {
            self.pagerControl.numberOfPages = 3
            self.pagerControl.contentHorizontalAlignment = .right
            self.pagerControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pagerControl.backgroundColor = .clear
            self.pagerControl.setFillColor(#colorLiteral(red: 0.968627451, green: 0.5960784314, blue: 0.1411764706, alpha: 1), for: .selected)
            self.pagerControl.setFillColor(#colorLiteral(red: 0.968627451, green: 0.5960784314, blue: 0.1411764706, alpha: 0.2), for: .normal)
            self.pagerControl.contentHorizontalAlignment = .center
            self.pagerControl.itemSpacing = 7

        }
    }

    //MARK:- Properities
    var homeVM = HomeVM()
    var realmModel = LocalCartItemsVM()
    var timer: Timer?
    var counter = 0
    fileprivate let bannerCell = "SliderCell"
    fileprivate let celebritiesCell = "CelebritiesCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        changeAddressButton.setTitle("", for: .normal)
        realmModel.delegate = self
        pagerView.delegate = self
        pagerView.dataSource = self
        registerCells()
        loadCelebrities()
        loadFirstBanner()
        if SharedData.SharedInstans.GetIsLogin() {
            getLastOrderData()
        }
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeFirstBanner), userInfo: nil, repeats: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        realmModel.fetchItems()
        deliverToLabel.text = "Deliver to" + " " + SharedData.SharedInstans.getAreaName()
        addressLabel.text = SharedData.SharedInstans.getAddres()
    }

    func registerCells() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: bannerCell, bundle: nil), forCellWithReuseIdentifier: bannerCell)

        celebritiesCollectionView.delegate = self
        celebritiesCollectionView.dataSource = self
        celebritiesCollectionView.register(UINib(nibName: celebritiesCell, bundle: nil), forCellWithReuseIdentifier: celebritiesCell)
    }

    func loadCelebrities() {
        homeVM.getCeleberities(pageNumber: 1) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.celebritiesCollectionView.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.homeVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    @objc func changeFirstBanner() {
        if counter < homeVM.bannerModel?.data?.count ?? 0 {
            bannerCollectionView.scrollToItem(at: IndexPath(item: counter, section: 0), at: .centeredHorizontally, animated: true)
            bannerPageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            bannerCollectionView.scrollToItem(at: IndexPath(item: counter, section: 0), at: .centeredHorizontally, animated: true)
            bannerPageControl.currentPage = counter
            counter = 1
        }
    }

    func loadFirstBanner() {
        homeVM.getBannarData(type: 0, areaId: -1) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.bannerCollectionView.reloadData()
                self.bannerPageControl.numberOfPages = self.homeVM.bannerModel?.data?.count ?? 0
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.homeVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func getLastOrderData() {
        homeVM.getLastOrder { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.setupLastOrder()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.homeVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func setupLastOrder() {
        if let lastOrder = homeVM.lastOrderData {
            inProgressOrderView.isHidden = false
            restaurantNameLabel.text = lastOrder.vendor?.name
            idLabel.text = "\(lastOrder.id ?? 0)"
            numberOfItemsLabel.text = "\(lastOrder.listOfCart?.count ?? 0) " + "items".localized()
            statusLabel.text = lastOrder.currentStepString
            inProgressImage.loadImageFromUrl(imgUrl: lastOrder.vendor?.logoFullPath, defString: "imageplaceholder")
        } else {
            inProgressOrderView.isHidden = true
        }
    }

    @IBAction func openInprogressButtonDidPress(_ sender: UIButton) {
    }

    @IBAction func sideMenuButtonDidPress(_ sender: UIButton) {
        sideMenuViewController?.presentLeftMenuViewController()
    }

    @IBAction func profileButtonDidPress(_ sender: UIButton) {
    }

    @IBAction func filterButtonDidPress(_ sender: UIButton) {
    }

    @IBAction func changeAddressButtonDidPress(_ sender: UIButton) {
        let addressVc = ShowOldAddressesVC.instantiate(fromAppStoryboard: .Home)
        addressVc.modalPresentationStyle = .overCurrentContext
        self.present(addressVc, animated: true, completion: nil)
    }
    @IBAction func openAllCelebritiesButtonDidPress(_ sender: UIButton) {
        let allCelebrityVc = AllCelebrityVC.instantiate(fromAppStoryboard: .Home)
        allCelebrityVc.modalPresentationStyle = .fullScreen
        present(allCelebrityVc, animated: true, completion: nil)
    }

    @IBAction func openCartDidPress(_ sender: UIButton) {
        let cartVc = CartVC.instantiate(fromAppStoryboard: .Home)
        cartVc.modalPresentationStyle = .fullScreen
        self.present(cartVc, animated: true, completion: nil)
    }

}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1000 {
            return homeVM.bannerModel?.data?.count ?? 0
        } else {
            return homeVM.celeberitiesModel?.data?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1000 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCell, for: indexPath) as? SliderCell else {return UICollectionViewCell()}
            if let banner = homeVM.bannerModel?.data?[indexPath.row] {
                cell.setupCell(data: banner)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: celebritiesCell, for: indexPath) as? CelebritiesCell else {return UICollectionViewCell()}
            if let celebrity = homeVM.celeberitiesModel?.data?[indexPath.row] {
                cell.setupCell(data: celebrity)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1000 {
            return CGSize(width: collectionView.frame.width, height: 170)
        } else {
            return CGSize(width: 103, height: 143)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        if collectionView.tag == 1000 {

        } else {
            if let celebrity = homeVM.celeberitiesModel?.data?[indexPath.row] {
                let celebrityVC = CelebritiesVC.instantiate(fromAppStoryboard: .Home)
                celebrityVC.celebrityId = celebrity.id ?? 0
                celebrityVC.celebrityImageURL = celebrity.mediaFullPath ?? ""
                celebrityVC.celebrityName = celebrity.name ?? ""
                celebrityVC.modalPresentationStyle = .fullScreen
                present(celebrityVC, animated: true, completion: nil)
            }
        }
    }
}

extension HomeVC: RealmViewModelDelegate {
    func recordFetch(items: [ItemOrderModel]) {
        var totalPrice = 0.0
        numberOfItemsLabel.text = "\(items.count) " + "ITEM".localized()
        for item in items {
            totalPrice += item.itemtotalPrice
        }

        totalCartPriceLabel.text = String(format: "%.2f", totalPrice)
    }
}

extension HomeVC: FSPagerViewDataSource,FSPagerViewDelegate{
    // MARK:- FSPagerView DataSource

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }

    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "placeholder")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = ""
        return cell
    }

    // MARK:- FSPagerView Delegate

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pagerControl.currentPage = targetIndex
    }

    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pagerControl.currentPage = pagerView.currentIndex
    }
}

extension HomeVC: ShowOldAddressesDelegate {
    func updateAddress() {
        addressLabel.text = SharedData.SharedInstans.getAddres()
    }
}

