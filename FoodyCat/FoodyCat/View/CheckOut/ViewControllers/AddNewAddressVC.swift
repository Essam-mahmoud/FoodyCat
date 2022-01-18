//
//  AddNewAddressVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 22/12/2021.
//

import UIKit
import GoogleMaps

class AddNewAddressVC: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var areaTF: UITextField!
    @IBOutlet weak var blockTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var buildingNoTF: UITextField!
    @IBOutlet weak var floorTF: UITextField!
    @IBOutlet weak var apartmentNoTF: UITextField!
    @IBOutlet weak var additionDirectionsTV: UITextView!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var mapViewCard: CardWithShadow!
    
    var addressesVM = AddressesVM()
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        areaTF.text = SharedData.SharedInstans.getAreaName()
        areaTF.isEnabled = false
        areaTF.textColor = UIColor.lightGray
    }

    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func addAddress(){
        guard let area = areaTF.text else {return}
        guard let block = blockTF.text else {return}
        guard let street = streetTF.text else {return}
        guard let buildingNo = buildingNoTF.text else {return}
        guard let floor = floorTF.text else {return}
        guard let apartmentNo = apartmentNoTF.text else {return}
        guard let phone = phoneNumberTF.text else {return}
        guard let additionalInfo = additionDirectionsTV.text else {return}

        if area != "" && block != "" && street != "" && buildingNo != "" {
            let address = "Block " + block + ", " + street + " Street, " + buildingNo + ", " + floor + ", " + apartmentNo
            addressesVM.addAddress(address: address, extaInfo: additionalInfo, phone: phone) { (errMsg, errRes, status) in
                switch status {
                case .populated:
                    let paymentVc = PaymentMethodVC.instantiate(fromAppStoryboard: .CheckOut)
                    paymentVc.address = self.addressesVM.addAddressResult
                    paymentVc.modalPresentationStyle = .fullScreen
                    self.present(paymentVc, animated: true, completion: nil)
                case .error:
                    AppCommon.sharedInstance.showBanner(title: self.addressesVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
                default:
                    break
                }
            }
        } else {
            AppCommon.sharedInstance.showBanner(title: "Please fill all Data to continue...".localized(), subtitle: "", style: .danger)
        }
    }

    @IBAction func completeButtonDidPress(_ sender: UIButton) {
        addAddress()
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension AddNewAddressVC: CLLocationManagerDelegate {
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
