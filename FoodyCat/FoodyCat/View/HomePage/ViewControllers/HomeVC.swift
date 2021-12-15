//
//  HomeVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 09/12/2021.
//

import UIKit

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

    //MARK:- Properities
    var homeVM = HomeVM()
    var timer: Timer?
    var counter = 0
    fileprivate let bannerCell = "SliderCell"
    fileprivate let celebritiesCell = "CelebritiesCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        loadCelebrities()
        loadFirstBanner()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeFirstBanner), userInfo: nil, repeats: true)
        }
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

    @IBAction func openInprogressButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func sideMenuButtonDidPress(_ sender: UIButton) {
        sideMenuViewController?.presentLeftMenuViewController()
    }
    @IBAction func profileButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func filterButtonDidPress(_ sender: UIButton) {
    }
    @IBAction func openAllCelebritiesButtonDidPress(_ sender: UIButton) {
        let allCelebrityVc = AllCelebrityVC.instantiate(fromAppStoryboard: .Home)
        allCelebrityVc.modalPresentationStyle = .fullScreen
        present(allCelebrityVc, animated: true, completion: nil)
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
