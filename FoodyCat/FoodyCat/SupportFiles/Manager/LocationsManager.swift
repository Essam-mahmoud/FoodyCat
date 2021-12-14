////
////  LocationManager.swift
////  Duty
////
////  Created by Mohamed Ismail on 6/11/18.
////  Copyright © 2018 GreenTech. All rights reserved.
////
//
//import UIKit
//import CoreLocation
////import GoogleMaps
////import GooglePlaces
//
//protocol CurrentLocationDelegate {
//    func didRecievedCurrentLocationUpdates(location:LocationBean)
//    func didFailedToGetCurrentLocation()
//}
//
//class LocationsManager: NSObject {
//  
//    static let sharedInstance = LocationsManager()
//    let locationManager = CLLocationManager()
//    var currentLocation : LocationBean?
//    var delegate : CurrentLocationDelegate?
//    var on: ((LocationBean?,Bool) -> ())?
//    var placesClient:GMSPlacesClient?
//    var alert : UIAlertController?
//
//    //MARK: - Methods
//   
//    
//    func run (){
//        LocationsManager.sharedInstance.getLocation()
//        placesClient = GMSPlacesClient.shared()
//    }
//
//    func getLocation() {
//        if CLLocationManager.locationServicesEnabled() {
//            if locationManager.delegate != nil {
//                locationManager.startUpdatingLocation()
//            }else {
//                locationManager.delegate = self
//                locationManager.distanceFilter = kCLDistanceFilterNone
//                locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                locationManager.requestWhenInUseAuthorization()
//                locationManager.startUpdatingLocation()
//            }
//        } else {
////            SVProgressHUD.dismiss()
//            openLocationServicesAlertController()
//        }
//    }
//    func getLocation(onComplete block:((LocationBean?,Bool) -> ())?) {
//        self.on = block
//        self.getLocation()
//    }
//    class func isAuthorized() -> Bool {
//        if  CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            return true
//        }
//        return false
//    }
//
//    func openLocationServicesAlertController(onCancel cancelBlock:ActionBlock? = nil) {
//        let title = "Alert".localized()
//        let message  = "Allow Elagk to access your location while you use the app".localized()
//        
////        if alert == nil {
//            alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            alert?.addAction(UIAlertAction.init(title: "Enable".localized(), style: .default
//                , handler: { (action) in
//                    if let aString = URL(string: UIApplication.openSettingsURLString){
//                        UIApplication.shared.open(aString, options: [:], completionHandler: nil)
//                    }
//            }))
////            alert?.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { (action) in
////                cancelBlock?()
////            }))
////        }
//        if let alert = alert , Util.UI.topViewController() != alert {
//            Util.UI.showAlert(alert: alert)
//        }
//
//
//    }
//    func autoComplete(usingGMS searchWord: String?, withCompletion complete: @escaping ([GMSAutocompletePrediction]?) -> Void) {
//        NSObject.cancelPreviousPerformRequests(withTarget: placesClient!)
//
//        if (searchWord?.count ?? 0) > 0 {
//            let filter = GMSAutocompleteFilter()
//            filter.type = .noFilter
//            let bounds = GMSCoordinateBounds.init(coordinate: (currentLocation?.locationCoordinate)!, coordinate: (currentLocation?.locationCoordinate)!)
//          
//            placesClient?.autocompleteQuery(searchWord!, bounds: bounds, filter: filter, callback: { results, error in
//                if error != nil {
//                    print("Autocomplete error \(error?.localizedDescription ?? "")")
//                    complete([GMSAutocompletePrediction]())
//                    return
//                }
//                if (results?.count ?? 0) > 0 {
//                    complete(results)
//                } else {
//                    complete([GMSAutocompletePrediction]())
//                }
//            })
//        } else {
//            complete([GMSAutocompletePrediction]())
//        }
//    }
//    
//
//}
//
//extension LocationsManager:CLLocationManagerDelegate{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("new current location")
//        self.currentLocation = LocationBean.initWith(lat: (locations.first?.coordinate.latitude) ?? 0.0, long: (locations.first?.coordinate.longitude) ?? 0.0, address: "")
//        LocationBean.initWith(coordinate: (manager.location?.coordinate)!) { (bean:LocationBean) in
//            self.currentLocation = bean
//            if let _ = self.delegate {
//                self.delegate?.didRecievedCurrentLocationUpdates(location: self.currentLocation!)
//            }
//            if let _ = self.on {
//                self.on!(self.currentLocation,true)
//                self.on = nil
//            }
//        }
//        manager.stopUpdatingLocation()
//    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
//        switch status {
//        case .authorizedAlways , .authorizedWhenInUse:
//            NotificationManager.sharedInstance.postNotification(type: .locationPermissionGranted, obj: nil)
//            break
//        case .denied:
//            if let _ = self.on {
//                self.on!(nil,false)
//            }
//            break
//        default:
//            break
//        }
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("failed to get current location")
//        if let clErr = error as? CLError {
//            switch clErr {
//            case CLError.locationUnknown:
//                print("location unknown")
//            case CLError.denied:
//                print("denied")
//                self.openLocationServicesAlertController()
//            default:
//                print("other Core Location error")
//            }
//        } else {
//            print("other error:", error.localizedDescription)
//        }
//        
//        if let _ = self.on {
//            self.on!(nil,false)
//        }
//    }
//    
////    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
////        if status == .denied {
////            print("failed to get current location due to permission issue")
////            self.openLocationServicesAlertController()
////            self.delegate?.didFailedToGetCurrentLocation()
////            if let _ = self.on {
////                self.on!(nil,false)
////            }
////        }
////    }
//}
