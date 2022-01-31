//
//  MyOrdersVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 31/01/2022.
//

import UIKit

class MyOrdersVC: UIViewController {

    @IBOutlet weak var ordersTableview: UITableView!
    @IBOutlet weak var noOrdersLabel: UILabel!
    fileprivate let cellName = "MyOrdersCell"
    var myOrdersVM = MyOrdersVM()
    var orders = [Order]()
    var pageNum = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupUI()
    }

    func registerCell() {
        ordersTableview.delegate = self
        ordersTableview.dataSource = self
        ordersTableview.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
    func setupUI() {
        if SharedData.SharedInstans.GetIsLogin() {
            getOrders()
        } else {
            noOrdersLabel.isHidden = false
        }
    }

    func getOrders() {
        myOrdersVM.getOrders(page: pageNum) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                guard let myOrders = self.myOrdersVM.orders?.data else {return}
                self.orders.append(contentsOf: myOrders)
                if self.orders.count > 0 {
                    self.noOrdersLabel.isHidden = true
                } else {
                    self.noOrdersLabel.isHidden = false
                }
                self.ordersTableview.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.myOrdersVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }
    
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension MyOrdersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? MyOrdersCell else {return UITableViewCell()}
        cell.setupCell(data: orders[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let orderVc = OrderDetailsVC.instantiate(fromAppStoryboard: .CheckOut)
        orderVc.orderId = orders[indexPath.row].id ?? 0
        orderVc.modalPresentationStyle = .fullScreen
        self.present(orderVc, animated: true, completion: nil)
    }
}

extension MyOrdersVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ordersTableview.contentOffset.y + ordersTableview.frame.height >= ordersTableview.contentSize.height {
            if pageNum < myOrdersVM.orders?.pageCount ?? 1 {
                pageNum += 1
                getOrders()
            }
        }
    }
}
