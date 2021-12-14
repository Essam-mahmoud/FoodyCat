//
//  LocationBean.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/11/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit
import CoreLocation

class LocationBean: NSObject {
    
    var locationCoordinate : CLLocationCoordinate2D?
    var address : String?
    
    
    class func initWith(coordinate:CLLocationCoordinate2D,onComplete: ((LocationBean)->())?){
        let bean = LocationBean()
        bean.locationCoordinate = coordinate
//        Util.Location.getAddresslocalityFromCoordinate(coordinate) { (address) in
//            bean.address = address
//            onComplete?(bean)
//        }
    }
    
    class func getLocality(coordinate:CLLocationCoordinate2D,onComplete:@escaping (String?)->()){

//        Util.Location.getAddresslocalityFromCoordinate(coordinate) { (address) in
//            onComplete(address)
//        }
    }

    class func initWith(lat:CLLocationDegrees,long:CLLocationDegrees,address:String)->LocationBean{
        let bean = LocationBean()
        let coordinate = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        bean.locationCoordinate = coordinate
        bean.address = address
        return bean
    }
}
