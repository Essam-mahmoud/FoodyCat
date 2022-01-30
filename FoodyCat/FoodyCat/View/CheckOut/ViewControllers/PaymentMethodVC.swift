//
//  PaymentMethodVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 22/12/2021.
//

import UIKit
import GoogleMaps

class PaymentMethodVC: UIViewController, GMSMapViewDelegate {

    //MARK:- Outlets
    @IBOutlet weak var methodsTableView: ContentSizedTableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var serviceChargeLAbel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var mapViewCard: CardWithShadow!
    
    //MARK:- Properties
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    var address: AddressData?
    var paymentsMethodVM = PaymentsMethodVM()
    var submitOrderVM = SubmitOrderVM()
    var realmModel = LocalCartItemsVM()
    var selectedItems = [ItemOrderModel]()
    var paramaters = [String: Any]()
    var selectionArray = [Bool]()
    var paymentMethodId = 0
    var totalPrice = 0.0
    var coupon = ""
    var paymentName = ""
    fileprivate let methodCellName = "PaymentMethodsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmModel.delegate = self
        realmModel.fetchItems()
        registerCell()
        setupUI()
        getPaymentMethods()
        setupLocationManager()

    }

    func registerCell() {
        methodsTableView.delegate = self
        methodsTableView.dataSource = self
        methodsTableView.register(UINib(nibName: methodCellName, bundle: nil), forCellReuseIdentifier: methodCellName)
    }

    func setupUI() {
        topTitleLabel.text = address?.name
        addressLabel.text = address?.addressLineOne
        phoneLabel.text = address?.phone
        nameLabel.text = SharedData.SharedInstans.getUserName()
    }

    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func getPaymentMethods() {
        paymentsMethodVM.getPaymentsMethods { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.methodsTableView.reloadData()
                self.fillArray()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.paymentsMethodVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }

    func fillArray() {
        guard let methods = paymentsMethodVM.methods else {return}
        for _ in methods {
            selectionArray.append(false)
        }
    }

    func selectionchange(index: Int) {
        for i in 0..<selectionArray.count {
            selectionArray[i] = false
        }
        selectionArray[index] = true
        methodsTableView.reloadData()
    }

    func checkPaymentMethod() -> Bool {
        for item in selectionArray {
            if item {
                return true
            }
        }
        return false
    }

    func getPaymentId() {
        for i in 0..<selectionArray.count {
            if selectionArray[i] {
                paymentMethodId = paymentsMethodVM.methods?[i].id ?? 0
                paymentName = paymentsMethodVM.methods?[i].title ?? ""
            }
        }
    }

    func fillRequestData() {
        var selectedAddress = [String: Any]()
        var items = [[String: Any]]()
        for item in selectedItems {
            var input = [String: Any]()
            input["id"] = item.Id
            input["quantity"] = item.quantity
            input["specialRequest"] = item.itemDescription
            input["celebrityId"] = SharedData.SharedInstans.getCelebrityId()
            if item.topping.count > 0 {
                var extra = [[String: Any]]()
                for extraTop in item.topping {
                    var addone = [String: Any]()
                    addone["id"] = extraTop.toppingId
                    extra.append(addone)
                }
                input["addons"] = extra
            }
            items.append(input)
        }

        selectedAddress["id"] = address?.id
        selectedAddress["lat"] = address?.lat
        selectedAddress["lng"] = address?.lng
        selectedAddress["phone"] = address?.phone
        selectedAddress["name"] = address?.name
        selectedAddress["addressLineOne"] = address?.addressLineOne
        selectedAddress["addressLineTwo"] = address?.addressLineTwo
        selectedAddress["createdUser"] = 0


        paramaters["vendorId"] = SharedData.SharedInstans.getVendorId()
        paramaters["orderId"] = 0
        paramaters["areaId"] = SharedData.SharedInstans.getAreaId()
        paramaters["coupon"] = coupon
        paramaters["paymentMethod"] = paymentMethodId
        paramaters["generalRequest"] = ""
        paramaters["items"] = items
        paramaters["address"] = selectedAddress
        paramaters["useWallet"] = false
        print(paramaters)
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitOrderButtonDidPress(_ sender: UIButton) {
        if checkPaymentMethod() {
            getPaymentId()
            fillRequestData()
            submitOrderVM.submitOrder(params: paramaters) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    let thankVc = ThanksPageVC.instantiate(fromAppStoryboard: .CheckOut)
                    thankVc.address = self.address
                    thankVc.orderNumber = self.submitOrderVM.submitResult?.data?.order?.id ?? 0
                    thankVc.payment = self.paymentName
                    thankVc.modalPresentationStyle = .fullScreen
                    self.present(thankVc, animated: true, completion: nil)
                case .error:
                    AppCommon.sharedInstance.showBanner(title: self.submitOrderVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
                default:
                    break
                }
            }
        } else {
            AppCommon.sharedInstance.showBanner(title: "Please select payment method to continue...".localized(), subtitle: "", style: .danger)
        }
    }
}

extension PaymentMethodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentsMethodVM.methods?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: methodCellName, for: indexPath) as? PaymentMethodsCell else {return UITableViewCell()}
        if let method = paymentsMethodVM.methods?[indexPath.row] {
            cell.setupCell(data: method, isSelected: selectionArray[indexPath.row])
        }

        cell.selectedTapped = {[weak self] selectedCell in
            self?.selectionchange(index: indexPath.row)
        }
        return cell
    }
}

extension PaymentMethodVC: RealmViewModelDelegate {
    func recordFetch(items: [ItemOrderModel]) {
        selectedItems = items
        for item in items {
            totalPrice += item.itemtotalPrice
        }
        subtotalLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice)
        serviceChargeLAbel.text = "KWD".localized() + " " + String(format: "%.2f", SharedData.SharedInstans.getDeliveryCharge())
        totalAmountLabel.text = "KWD".localized() + " " + String(format: "%.2f", totalPrice + SharedData.SharedInstans.getDeliveryCharge())
    }
}


extension PaymentMethodVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
        mapView = GMSMapView.map(withFrame: mapViewCard.bounds, camera: camera)
        mapView.layer.cornerRadius = 15
        mapView.delegate = self
        mapViewCard.addSubview(mapView)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.map = mapView
        mapViewCard.isUserInteractionEnabled = false
    }
}
