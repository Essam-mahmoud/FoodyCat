//
//  AppConstants.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/10/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import Foundation

enum Environment {
    case development
    case production
    case other
}

struct MenuItem {
    var imageName: String
    var title: String
}

class AppConstant: NSObject {
    
    class Google: NSObject {
        public static let GOOGLE_MAP_API = "AIzaSyBHDd3aOHu34xA3UX8RGHUSOFs_tPujhvA"
    }
    
    class UrlHandler: NSObject{
        
        static var configuration : Environment = .development
        static let timeOut = 60.0
        
        static var lang = LanguageManager.getLangForApiPath()
        //https://api.foodycat.com/api/

        
        static var apiDomain : String {
            return "https://api.foodycat.com/api/"
        }
        static public var Login : String {
            return "\(apiDomain)Customer/login"
        }

        static public var register: String {
            return "\(apiDomain)Customer/register"
        }

        static public var forgetPassword: String {
            return "\(apiDomain)Customer/forgetpassword"
        }

        static public var getCelebrities: String {
            return "\(apiDomain)Celebrities"
        }

        static public var getRestaurant: String {
            return "\(apiDomain)Vendors/"
        }

        static public var getBanners: String {
            return "\(apiDomain)Banners/"
        }

        static public var getMenuItems: String {
            return "\(apiDomain)shop/Branches/"
        }

        static public var getAreaId: String {
            return "\(apiDomain)Coverage/GetLocation"
        }

        static public var getAddresses: String {
            return "\(apiDomain)Customer/Address"
        }

        static public var getPayments: String {
            return "\(apiDomain)Vendors/"
        }

        static public var submitOrder: String {
            return "\(apiDomain)Order/place"
        }

        static public var lastOrder: String {
            return "\(apiDomain)Customer/Orders/last"
        }

        static public var orderDetails: String {
            return "\(apiDomain)Customer/Orders/"
        }

        static public var getOrders: String {
            return "\(apiDomain)Customer/Orders"
        }
    }
}
