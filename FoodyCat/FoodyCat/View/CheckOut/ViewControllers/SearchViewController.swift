//
//  SearchViewController.swift
//  FoodyCat
//
//  Created by Essam Orabi on 26/02/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTF: UISearchBar!
    @IBOutlet weak var celebrityCollectionView: UICollectionView!
    @IBOutlet weak var vendorTableView: UITableView!

    var searchVM = SearchVM()
    fileprivate let tableCell = "SearchedVendorCell"
    fileprivate let collectionCell = "SearchedCelebrityCell"
    var searchText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        searchTF.delegate = self
        searchTF.placeholder = "Search here...".localized()
        searchTF.becomeFirstResponder()
    }

    func registerCells() {
        celebrityCollectionView.delegate = self
        celebrityCollectionView.dataSource = self
        celebrityCollectionView.register(UINib(nibName: collectionCell, bundle: nil), forCellWithReuseIdentifier: collectionCell)

        vendorTableView.delegate = self
        vendorTableView.dataSource = self
        vendorTableView.register(UINib(nibName: tableCell, bundle: nil), forCellReuseIdentifier: tableCell)
    }

    func getSearchedVendors(vendorName: String) {
        searchVM.getVendors(vendorName: vendorName) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.vendorTableView.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.searchVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func getsearchedCelebrity(celebrityName: String) {

    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.vendors?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as? SearchedVendorCell else {return UITableViewCell()}
        if let vendor = searchVM.vendors?.data?[indexPath.row] {
            cell.setupCell(data: vendor)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let vendor = searchVM.vendors?.data?[indexPath.row] {
            let vendorVc = VendorVC.instantiate(fromAppStoryboard: .Home)
            vendorVc.isComeFromHome = true
            vendorVc.vendorImageURL = vendor.logo ?? ""
            vendorVc.vendorId = vendor.id ?? 0
            vendorVc.deliveryCharge = vendor.deliveryCharge ?? 0.0
            vendorVc.vendorSpeciality = vendor.cuisines ?? ""
            vendorVc.vendorNameLable = vendor.name ?? ""
            vendorVc.vendorRating = vendor.rating ?? 0
            vendorVc.modalPresentationStyle = .fullScreen
            self.present(vendorVc, animated: true, completion: nil)
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as? SearchedCelebrityCell else {return UICollectionViewCell()}
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //    searchActive = false
        if searchBar.text! == ""{
            AppCommon.sharedInstance.showBanner(title: "Enter text to search!".localized(), subtitle: "", style: .danger)
        }else{
            searchText = searchBar.text!
            getSearchedVendors(vendorName: searchText)
            getsearchedCelebrity(celebrityName: searchText)
            searchTF.endEditing(true)
        }
    }
}


