//
//  GetUserLocationVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 20/12/2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class GetUserLocationVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var addressLabel: UILabel!

    var locationManager = CLLocationManager()
    var savedAddresses = [SavedAddressesModel]()
    var mapView: GMSMapView!
    var long = 0.0
    var lat = 0.0
    var isFromHomePage = false
    var getAreaIdVM = GetAreaIdVM()
    let searchVC = UISearchController(searchResultsController: ResultViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        searchVC.searchResultsUpdater = self
        searchView.addSubview(searchVC.searchBar)
        savedAddresses = SharedData.SharedInstans.loadAddresses()
        print(GMSServices.openSourceLicenseInfo())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func saveAddress() {
        let address = SavedAddressesModel(
            areaId: getAreaIdVM.areaResult?.areaID ?? 0,
            address: getAreaIdVM.areaResult?.addressLineOne ?? "",
            long: getAreaIdVM.areaResult?.lng ?? 0.0,
            lat: getAreaIdVM.areaResult?.lat ?? 0.0,
            areaName: getAreaIdVM.areaResult?.area ?? "")
        savedAddresses.append(address)
        SharedData.SharedInstans.saveAddresses(savedAddresses: savedAddresses)
    }
    
    @IBAction func confirmButtonDidPress(_ sender: UIButton) {
        getAreaIdVM.getAreaId(long: long, lat: lat) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                SharedData.SharedInstans.setAreaName(self.getAreaIdVM.areaResult?.area ?? "")
                SharedData.SharedInstans.setAreaId(self.getAreaIdVM.areaResult?.areaID ?? 0)
                SharedData.SharedInstans.setLat("\(self.getAreaIdVM.areaResult?.lat ?? 0.0)")
                SharedData.SharedInstans.setLng("\(self.getAreaIdVM.areaResult?.lng ?? 0.0)")
                SharedData.SharedInstans.setAddress(self.getAreaIdVM.areaResult?.addressLineOne ?? "")
                SharedData.SharedInstans.SetShowMap(true)
                self.saveAddress()
                if self.isFromHomePage {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? HomeVC else {return}
                    UIApplication.shared.windows.first?.rootViewController = homeVC
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.getAreaIdVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }
}

extension GetUserLocationVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
        mapView = GMSMapView.map(withFrame: mainView.frame, camera: camera)
        mapView.delegate = self
        mainView.addSubview(mapView)
        long = coordinate.longitude
        lat = coordinate.latitude

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.map = mapView
        getAdressName(coords: location)
    }
}

extension GetUserLocationVC: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let marker = GMSMarker(position: coordinate)
        let decoder = CLGeocoder()
        decoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, err in
           if let placeMark = placemarks?.first {

               let placeName = placeMark.name ?? placeMark.subThoroughfare ?? placeMark.thoroughfare!   ///Title of Marker
               //Formatting for Marker Snippet/Subtitle
               var address : String! = ""
               if let subLocality = placeMark.subLocality ?? placeMark.name {
                   address.append(subLocality)
                   address.append(", ")
               }
               if let city = placeMark.locality ?? placeMark.subAdministrativeArea {
                   address.append(city)
                   address.append(", ")
               }
               if let state = placeMark.administrativeArea, let country = placeMark.country {
                   address.append(state)
                   address.append(", ")
                   address.append(country)
               }

               // Adding Marker Details
               self.addressLabel.text = placeName + "," + address
               self.lat = coordinate.latitude
               self.long = coordinate.longitude
               marker.title = placeName
               marker.snippet = address
               marker.appearAnimation = .pop
               marker.map = mapView
           }
       }
    }
}

extension GetUserLocationVC {
    func getAdressName(coords: CLLocation) {

        CLGeocoder().reverseGeocodeLocation(coords) { (placemark, error) in
                if error != nil {
                    print("Hay un error")
                } else {

                    let place = placemark! as [CLPlacemark]
                    if place.count > 0 {
                        let place = placemark![0]
                        var adressString : String = ""
                        if place.thoroughfare != nil {
                            adressString = adressString + place.thoroughfare! + ", "
                        }
                        if place.subThoroughfare != nil {
                            adressString = adressString + place.subThoroughfare! + "\n"
                        }
                        if place.locality != nil {
                            adressString = adressString + place.locality! + " - "
                        }
                        if place.postalCode != nil {
                            adressString = adressString + place.postalCode! + "\n"
                        }
                        if place.subAdministrativeArea != nil {
                            adressString = adressString + place.subAdministrativeArea! + " - "
                        }
                        if place.country != nil {
                            adressString = adressString + place.country!
                        }

                        self.addressLabel.text = adressString
                    }
                }
            }
      }
}

extension GetUserLocationVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, let resultsVC = searchController.searchResultsController as? ResultViewController else {return}

        resultsVC.delegate = self
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultsVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension GetUserLocationVC: ResultViewControllerDelegate {
    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true, completion: nil)
        lat = coordinates.latitude
        long = coordinates.longitude
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        getAdressName(coords: location)
        let marker = GMSMarker()
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15)
        mapView.clear()
        mapView.camera = camera
        marker.position = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        marker.map = mapView
    }
}
