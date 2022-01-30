//
//  ShowOldAddressesVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 24/01/2022.
//

import UIKit

protocol ShowOldAddressesDelegate {
    func updateAddress()
}

class ShowOldAddressesVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addressesTableView: UITableView!
    @IBOutlet weak var openMapButton: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    let cellName = "SavedAddressCell"
    var delegate: ShowOldAddressesDelegate?
    var savedAaddresses = [SavedAddressesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        openMapButton.setTitle("", for: .normal)
        topView.darkBlurView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        topView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAddresses()
        mainView.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }

    func registerCell() {
        addressesTableView.delegate = self
        addressesTableView.dataSource = self
        addressesTableView.tableFooterView = UIView()
        addressesTableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }

    func loadAddresses() {
        savedAaddresses = SharedData.SharedInstans.loadAddresses()
        if savedAaddresses.count > 0 {
            noDataLabel.isHidden = true
        } else {
            noDataLabel.isHidden = false
        }
        addressesTableView.reloadData()
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.updateAddress()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openMapButtonDidPress(_ sender: UIButton) {
        let mapVc = GetUserLocationVC.instantiate(fromAppStoryboard: .Home)
        mapVc.isFromHomePage = true
        mapVc.modalPresentationStyle = .fullScreen
        self.present(mapVc, animated: true, completion: nil)
    }
}

extension ShowOldAddressesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedAaddresses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? SavedAddressCell else {return UITableViewCell()}
        cell.setupCell(data: savedAaddresses[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = savedAaddresses[indexPath.row]
        SharedData.SharedInstans.setAreaName(address.areaName ?? "")
        SharedData.SharedInstans.setAreaId(address.areaId ?? 0)
        SharedData.SharedInstans.setLat("\(address.lat ?? 0.0)")
        SharedData.SharedInstans.setLng("\(address.long ?? 0.0)")
        SharedData.SharedInstans.setAddress(address.address ?? "")
        delegate?.updateAddress()
        self.dismiss(animated: true, completion: nil)
    }
}
