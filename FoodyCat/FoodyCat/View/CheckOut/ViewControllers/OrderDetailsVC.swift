//
//  OrderDetailsVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 29/01/2022.
//

import UIKit

class OrderDetailsVC: UIViewController {

    @IBOutlet weak var StatusImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deliveryProgressWidth: NSLayoutConstraint!
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var orderTableview: ContentSizedTableView!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderAmountLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var progressWidthView: UIView!
    @IBOutlet weak var progressColordView: UIView!

    let thankCellName = "thanksCell"
    let orderDetailsVM = OrderDetailsVM()
    var orderId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        getOrderDetails()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressWidthView.layer.cornerRadius = 10
        progressColordView.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            progressWidthView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            progressColordView.layer.maskedCorners = [.layerMinXMaxYCorner]
        } else {
        }
    }

    func registerCells(){
        orderTableview.delegate = self
        orderTableview.dataSource = self
        orderTableview.register(UINib(nibName: thankCellName, bundle: nil), forCellReuseIdentifier: thankCellName)
    }

    func getOrderDetails() {
        orderDetailsVM.getOrder(id: orderId) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.setupUI()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.orderDetailsVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func setupUI() {
        let order = orderDetailsVM.order
        areaNameLabel.text = SharedData.SharedInstans.getAreaName()
        addressLabel.text = order?.address?.addressLineOne
        nameLabel.text = SharedData.SharedInstans.getUserName()
        phoneLabel.text = order?.address?.phone
        vendorNameLabel.text = order?.vendor?.name
        vendorImage.loadImageFromUrl(imgUrl: order?.vendor?.logoFullPath, defString: "imageplaceholder")
        orderNumberLabel.text = "\(order?.id ?? 0)"
        let price = order?.grandTotal ?? 0.0
        let doublePrice = Double(round(1000 * price) / 1000)
        orderAmountLabel.text = "KWD".localized() + " " + "\(doublePrice)"
        paymentMethodLabel.text = order?.paymentMethodString
        timeLabel.text = order?.expectedDeliveryTime
        orderTableview.reloadData()

        switch order?.currentStep {
        case 0:
            StatusImage.image = UIImage(named: "Delivery1")
            deliveryProgressWidth.constant = progressWidthView.bounds.width * 0.1
        case 1:
            StatusImage.image = UIImage(named: "Delivery1")
            deliveryProgressWidth.constant = progressWidthView.bounds.width * 0.1
        case 2:
            StatusImage.image = UIImage(named: "Delivery1")
            deliveryProgressWidth.constant = progressWidthView.bounds.width * 0.25
        case 3:
            StatusImage.image = UIImage(named: "Delivery1")
            deliveryProgressWidth.constant = progressWidthView.bounds.width * 0.5
        case 4:
            StatusImage.image = UIImage(named: "Delivery1")
            deliveryProgressWidth.constant = progressWidthView.bounds.width * 0.6
        case 5:
            StatusImage.image = UIImage(named: "Delivery2")
            deliveryProgressWidth.constant = progressWidthView.bounds.width * 0.7
        case 6:
            StatusImage.image = UIImage(named: "Delivery2")
            deliveryProgressWidth.constant = progressWidthView.bounds.width * 0.8
        case 7:
            StatusImage.image = UIImage(named: "Delivery2")
            deliveryProgressWidth.constant = progressWidthView.bounds.width
            progressColordView.layer.cornerRadius = 10
            progressColordView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        case 8:
            StatusImage.image = UIImage(named: "Delivery2")
            deliveryProgressWidth.constant = progressWidthView.bounds.width
            progressColordView.layer.cornerRadius = 10
            progressColordView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        default:
            break
        }
    }
    
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension OrderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetailsVM.order?.listOfCart?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: thankCellName, for: indexPath) as? thanksCell else {return UITableViewCell()}
        if let cards = orderDetailsVM.order?.listOfCart {
            cell.setupCellList(data: cards[indexPath.row])
        }
        return cell
    }
}
