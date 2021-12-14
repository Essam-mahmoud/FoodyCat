//
//  Helper.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/6/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
//import Cosmos
import Photos
import Alamofire
//import GoogleMaps
import MapKit
import AVKit
//import YPImagePicker

//import WXImageCompress
//import libPhoneNumber_iOS
class Util: NSObject{
    func didSelect(image: UIImage?) {
        print(123)
    }
    
    static let sharedInstance = Util()
    
    //    class func playVideo(content:ContentDTO?,list:[ContentDTO]? = nil,StartFrom:Int = 0){
    //        StreamPlayerVC.openPlayer(content: content,list: list,StartFromSecond:StartFrom)
    //
    //    }
    func callPhone(phone:String,button:UIButton = UIButton()){
        let phone = Util.NumberUtil.getEnglishNumber(in: phone)
        if let url = URL(string: "tel:\(phone)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { (sucesss) in
                    
                }
                button.isEnabled = false
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(enableCallBtn(sender:)), userInfo: ["sender": button], repeats: false)
            } else {
                Util.UI.showAlert(title: "Alert!".localized(), message: "This function is only available on an iPhone.".localized())
            }
        }
    }
    func openEmail(email:String){
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    func openTwitter(twitterId:String){
        let appURL = URL(string: "twitter://user?screen_name=\(twitterId)")!
        let webURL = URL(string: "https://twitter.com/\(twitterId)")!
        
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
    func openInstagram(instagramId:String){
        let appURL = URL(string: "instagram://user?username=\(instagramId)")!
        let webURL = URL(string: "http://instagram.com/\(instagramId)")!
        
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
    @objc func enableCallBtn(sender:Timer){
        if let userInfo = sender.userInfo as? JSONAlis , let callBtn = userInfo["sender"] as? UIButton{
            callBtn.isEnabled = true
        }
        
    }
    ///////////////////////// UI /////////////////////////
    class UI : NSObject , UIImagePickerControllerDelegate {
        static let sharedInstance = UI()
        static let APP_COLOR = UIColor.white
        static let APP_TINT_COLOR = UIColor(hex: 0x2B477B)
        
        //        0x880F50
        static let babyPukeGreen = UIColor(red: 179, green: 212, blue :212)
        
        class func getAppColor(alpha:CGFloat)->UIColor{
            return UIColor.init(red: 43/255.0, green: 71/255.0, blue: 123/255.0, alpha: alpha)
        }
        class func getTextAlignment()->NSTextAlignment{
            return LanguageManager.isArabic() ? .right : .left
        }
        class func showAlert(alert:UIAlertController){
            if let perviousalert = topViewController() as? UIAlertController{
                perviousalert.dismiss(animated: true) {
                    topViewController()?.navigationController?.visibleViewController?.present(alert, animated: true, completion: nil)
                    
                }
            }else if let vc = topViewController()?.navigationController?.visibleViewController{
                vc.present(alert, animated: true, completion: nil)
            }else {
                topViewController()?.present(alert, animated: true, completion: nil)
            }
        }
        class  func alert(title: String, message: String, controller: UIViewController, actionTitle: String, actionStyle: UIAlertAction.Style) {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: nil))
            alert.view.tintColor = UIColor.hexColor(string: "023f82")
            
            controller.present(alert, animated: true, completion: nil)
            
        }
        
        class func showAlert(title:String="Message".localized(),message:String){
            let alertController = UIAlertController.init(title: title, message: message
                , preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK".localized(), style: .default, handler: nil))
            Util.UI.showAlert(alert: alertController)
            
        }
        class func updateNavBar(nav:UINavigationController){
            nav.navigationBar.barTintColor = APP_COLOR
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.barStyle = .black
            nav.navigationBar.backgroundColor = UIColor.clear
            
            nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(), NSAttributedString.Key.foregroundColor:APP_TINT_COLOR]
        }
        class func makeClearNavBar(nav:UINavigationController){
            nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
            nav.navigationBar.shadowImage = UIImage();
            nav.navigationBar.isTranslucent = true;
            nav.view.backgroundColor = .clear;
            nav.navigationBar.backgroundColor = .clear;
        }
        class func updateAllNavBars(){
            UINavigationBar.appearance().barTintColor = APP_COLOR
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barStyle = .black
            UINavigationBar.appearance().backgroundColor = UIColor.clear
            UIBarButtonItem.appearance().setTitleTextAttributes(
                [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(), NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(), NSAttributedString.Key.foregroundColor:UIColor.white]
            
        }
        class func updateNavBarToNoNav(nav:UINavigationController){
            nav.navigationBar.barTintColor = UIColor.clear
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
            nav.navigationBar.isTranslucent = true
            nav.navigationBar.barStyle = .black
            nav.navigationBar.backgroundColor = UIColor.clear
            
            nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(), NSAttributedString.Key.foregroundColor:UIColor.white]
        }
        //        class func buildImageUrl(name:String?)->URL?{
        //            if let _ = name {
        //                return (AppConstant.UrlHandler.IMAGE_PATH + name! ).url()
        //            }else {
        //                return nil
        //            }
        //        }
        class func setTitle(title:String,forBtn btn:UIButton?){
            btn?.setTitle(title, for: .normal)
            btn?.setTitle(title, for: .highlighted)
            btn?.setTitle(title, for: .selected)
        }
        class func getSemantic()->UISemanticContentAttribute{
            if LanguageManager.isArabic() {
                return .forceRightToLeft
            }else {
                return .forceLeftToRight
            }
        }
        //        class func updateRatingView(view:CosmosView){
        //            view.settings.starMargin = 0;
        //            view.settings.starSize = Double(view.frame.size.width / 5.0)
        //        }
        
        class func dropShadow(view:UIView?,shadowColor:UIColor = UIColor.gray){
            view?.layer.shadowOffset = CGSize(width: 0, height: 0);
            view?.layer.shadowColor = shadowColor.cgColor
            view?.layer.shadowRadius = 2.5;
            view?.layer.shadowOpacity = 0.5;
        }
        class func dropShadow(view:UIView?,superView:UIView?){
            view?.layer.shadowOffset = CGSize(width: 0, height: 0)
            view?.layer.shadowColor = UIColor.gray.cgColor
            view?.layer.shadowRadius = 3
            view?.layer.shadowOpacity = 0.50
            let shadowFrame: CGRect? = view?.layer.bounds
            let shadowPath = UIBezierPath(rect: shadowFrame ?? CGRect.zero).cgPath
            superView?.layer.shadowPath = shadowPath
            view?.layer.cornerRadius = 3
            
            
        }
        class func getAssetThumbnail(asset: PHAsset) -> UIImage {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 250, height: 250), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
            return thumbnail
        }
        
        class func topViewController() -> UIViewController? {
            let rootViewController = AppDelegate.getIntance().window?.rootViewController
            if rootViewController is UINavigationController {
                if let nav = rootViewController as? UINavigationController{
                    return nav.visibleViewController
                }
            }else if let vc = rootViewController?.presentedViewController{
                if let nav = vc as? UINavigationController{
                    return nav.visibleViewController
                }else {
                    return rootViewController?.presentedViewController
                }
            }
            return rootViewController
        }
        
        
        class func openImagePicker(vc:UIViewController,  onImageSelect:ImagePickerBlock?){
            
            
            
        }
        class func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            shapeLayer.lineWidth = 1
            shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.
            
            let path = CGMutablePath()
            path.addLines(between: [p0, p1])
            shapeLayer.path = path
            view.layer.addSublayer(shapeLayer)
        }
    }
    
    ///////////////////////// validator /////////////////////////
    class phoneValidator {
        
    }
    
    ///////////////////////// Date /////////////////////////
    class DateTimeUtil {
        static let TIME_ZONE = TimeZone.current
        
        class func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
            return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        }
        
        class func getCurrentDateTime()->String{
            return getFormattedDate(date: Date())
        }
        class func getEnglishLocalForAppLanuage()->(Locale){
            let local = Locale(identifier: "en_US" )
            return local
        }
        class func getCurrentLocal()->(Locale){
            if LanguageManager.isArabic(){
                return Locale(identifier: "ar")
            }
            return Locale(identifier: "en")
        }
        class func getCurrentDateTimeFormated(stringFormat:String)->(String){
            let local = Locale.init(identifier: "en_US")
            let now = Date()
            let dateFormatter = DateFormatter()
            if let anAbbreviation = NSTimeZone(abbreviation: "GMT") {
                dateFormatter.timeZone = anAbbreviation as TimeZone
            }
            dateFormatter.dateFormat = stringFormat
            dateFormatter.locale = local as Locale
            let dateTimeInIsoFormatForZuluTimeZone = dateFormatter.string(from: now)
            return dateTimeInIsoFormatForZuluTimeZone
        }
        class func getFormattedDate(date:Date? , format:String = "yyyy-MM-dd HH:mm:ss",locale:Locale = LanguageManager.getEnglishLocalForAppLanuage()!)->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.locale = locale
            dateFormatter.timeZone = DateTimeUtil.TIME_ZONE
            return dateFormatter.string(from: date ?? Date())
            
        }
        class func getFormattedDate(source:String, fromFormat:String,toFormat:String,fromlocale:Locale,tolocale:Locale)->String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = fromFormat
            dateFormatter.locale = fromlocale
            dateFormatter.timeZone = DateTimeUtil.TIME_ZONE
            let date = dateFormatter.date(from: source)
            dateFormatter.dateFormat = toFormat
            dateFormatter.locale = tolocale
            
            return dateFormatter.string(from: date ?? Date())
            
        }
        class func getDateFromEpochTime(_ timeStamp: Double?) -> Date? {
            let interval = TimeInterval(timeStamp ?? 0.0)
            let date = Date(timeIntervalSince1970: (interval / 1000))
            let string = DateTimeUtil.getFormattedDate(date: date)
            return DateTimeUtil.getDate(fromString: string, format: "yyyy-MM-dd HH:mm:ss", locale: LanguageManager.getLocale()!)
        }
        class func getDate(fromString:String,format:String,locale:Locale)-> Date?{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.locale = locale
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Riyadh")
            return dateFormatter.date(from: fromString)
            
        }
        
        class func timeAgoSinceDate(dateString:String?, format:String = "yyyy-MM-dd") -> String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.locale = LanguageManager.getEnglishLocalForAppLanuage()
            
            let gregorianCalendar = Calendar(identifier: .gregorian)
            var output = ""
            
            if let date = dateFormatter.date(from: dateString ?? "") {
                var components = gregorianCalendar.dateComponents([.day,.month,.year], from: date, to: Date())
                if components.year! > 0 {
                    if components.year == 1 {
                        output = "one year ago".localized()
                    } else {
                        if LanguageManager.isArabic(){
                            output = ("\("ago".localized()) \(Util.NumberUtil.localizeNumbers(in: ("\(components.year ?? 0)"))) \("years".localized())")
                        }else{
                            output = Util.NumberUtil.localizeNumbers(in: ("\(components.year ?? 0) years ago").localized())
                        }
                    }
                } else if components.month! > 0 {
                    if components.month == 1 {
                        output = "one month ago".localized()
                    } else {
                        if LanguageManager.isArabic(){
                            output = ("\("ago".localized()) \(Util.NumberUtil.localizeNumbers(in: ("\(components.month ?? 0)"))) \("months".localized())")
                        }else{
                            output = Util.NumberUtil.localizeNumbers(in: ("\(components.month ?? 0) months ago").localized())
                        }
                    }
                } else {
                    if components.day == 0 {
                        output = "Today".localized()
                    } else if components.day == 1 {
                        output = "Yesterday".localized()
                    } else {
                        if LanguageManager.isArabic(){
                            output = ("\("ago".localized()) \(Util.NumberUtil.localizeNumbers(in: ("\(components.day ?? 0)"))) \("days".localized())")
                        }else{
                            output = Util.NumberUtil.localizeNumbers(in: ("\(components.day ?? 0) days ago").localized())
                        }
                        
                    }
                }
            }
            
            return output
        }
    }
    class Parse {
        class func getDouble(_ input:JSONAlis,key:String)->Double{
            if let value = input[key] , !(value is NSNull){
                if value is String {
                    return (Double.init((value as? String) ?? "0.0" )) ?? 0.0
                }else if value is Double {
                    return value as! Double
                }
            }
            return 0.0
        }
    }
    /////////////////////// number ///////////////////////
    class NumberUtil {
        
        class func localizeNumbers(in input: String) -> String {
            let inputString = String(describing: input)
            // add condition for checking on the selected language first , if english then
            if LanguageManager.isArabic() == false {
                // if english
                return Util.NumberUtil.getEnglishNumber(in:inputString)
            }
            
            // if arabic
            return Util.NumberUtil.getArabicNumber(in:inputString)
            
        }
        
        class func localizeDoubleNumbers(in input: Double) -> String {
            let inputString = String(describing: input)
            // add condition for checking on the selected language first , if english then
            if LanguageManager.isArabic() == false {
                // if english
                return Util.NumberUtil.getEnglishNumber(in:inputString)
            }
            
            // if arabic
            return Util.NumberUtil.getArabicNumber(in:inputString)
            
        }
        
        class func getEnglishNumber(in input: String) -> String {
            var inputString = String(describing: input)
            let numbersDictionary = ["١": "1", "٢": "2", "٣": "3", "٤": "4", "٥": "5", "٦": "6", "٧": "7", "٨": "8", "٩": "9", "٠": "0"]
            for key in numbersDictionary.keys {
                inputString = inputString.replacingOccurrences(of: key, with: numbersDictionary[key]!)
            }
            return inputString
        }
        class func getArabicNumber(in input: String) -> String {
            var inputString = String(describing: input)
            let numbersDictionary = ["1": "١", "2": "٢", "3": "٣", "4": "٤", "5": "٥", "6": "٦", "7": "٧", "8": "٨", "9": "٩", "0": "٠"]
            for key in numbersDictionary.keys {
                inputString = inputString.replacingOccurrences(of: key, with: numbersDictionary[key]!)
            }
            return inputString
        }
        
        class func formatCurrency(_ money: Double?) -> String? {
            let formatter = NumberFormatter()
            formatter.positiveFormat = "0.00"
            let moneyString = money ?? Double()
            //let moneyString = formatter.string(from: moneyNumber as NSNumber)
            return LanguageManager.isArabic() ? "\(Util.NumberUtil.localizeDoubleNumbers(in: moneyString))\(" ريال ")" : "\(Util.NumberUtil.localizeDoubleNumbers(in: moneyString))\(" SAR")"
        }
        
    }
    
    
    class Location {
        class func openNavigatoinApps(destination:CLLocationCoordinate2D,from:UIViewController? = Util.UI.topViewController()){
            let alertController = UIAlertController(title: "Select app for navigation", message: "", preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Apple Maps", style: .default, handler: { (action) in
                Util.Location.openAppleMapDirection(destination: destination)
            }))
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)){
                alertController.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { (action) in
//                    Util.Location.openGoogleMapDirection(destination: destination)
                }))
            }
            if (UIApplication.shared.canOpenURL(URL(string:"uber://")!)){
                alertController.addAction(UIAlertAction(title: "Uber", style: .default, handler: { (action) in
//                    Util.Location.openUberDirection(destination: destination)
                }))
            }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            from?.present(alertController, animated: true, completion: nil)
        }
        
        
        class func openAppleMapDirection(destination:CLLocationCoordinate2D){
            let placeMark = MKPlacemark(coordinate: destination, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placeMark)
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        }
//        class func openGoogleMapDirection(destination:CLLocationCoordinate2D){
//        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//        let start = "\(LocationsManager.sharedInstance.currentLocation?.locationCoordinate?.latitude ?? 0.0),\(LocationsManager.sharedInstance.currentLocation?.locationCoordinate?.longitude ?? 0.0)"
//        let destination = "\(destination.latitude),\(destination.longitude)"
//        let url = (URL(string:
//        "comgooglemaps://?saddr=\(start)&daddr=\(destination)&directionsmode=driving,views=transit")!)
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//        print("Can't use comgooglemaps://");
//        }
//        }
//        class func openUberDirection(destination:CLLocationCoordinate2D){
//            if let currentLocation = LocationsManager.sharedInstance.currentLocation?.locationCoordinate{
//                let urlString =  "uber://?client_id=dfv23qfe23&action=setPickup&pickup[latitude]=\(currentLocation.latitude)&pickup[longitude]=\(currentLocation.longitude)&dropoff[latitude]=\(destination.latitude)&dropoff[longitude]=\(destination.longitude)"
//                if (UIApplication.shared.canOpenURL(URL(string:"uber://")!)) {
//                    UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
//
//                }else {
//                    print("Can't use uber://");
//                }
//            }
//        }
//        class func getAddressFromCoordinate(_ coordinate: CLLocationCoordinate2D, onComplete completionHandler:  ((_ address: String?) -> Void)?) {
//            let coder = GMSGeocoder()
//            coder.reverseGeocodeCoordinate(coordinate, completionHandler: { response, err in
//                DispatchQueue.main.async {
//                    if err == nil {
//                        let address = response?.firstResult()?.lines?.joined(separator: ",")
//                        completionHandler?(address ?? "")
//                    } else {
//                        completionHandler?("")
//                    }
//                }
//
//            })
//        }
//        class func getAddresslocalityFromCoordinate(_ coordinate: CLLocationCoordinate2D, onComplete completionHandler: @escaping (_ address: String?) -> Void) {
//            let coder = GMSGeocoder()
//
//            coder.reverseGeocodeCoordinate(coordinate, completionHandler: { response, err in
//                if err == nil {
//
//                    //                    let filtered = response?.results()?.reversed().filter({$0.locality != nil}).first
//                    let address = response?.results()?.first?.country ?? Locale.current.regionCode
//                    completionHandler(address ?? "")
//                } else {
//                    completionHandler("")
//                }
//            })
//        }
    }
    
}



class Section : NSObject {
    var rows : [Row]?
    var title : String?
    var obj : Any?
    
    init(title:String,rows:[Row]? ) {
        super.init()
        self.title = title
        self.rows = rows
    }
}
class Row : NSObject {
    var cellId : String?
    var obj : Any?
    
    init(cellId : String?,obj:Any? = nil) {
        super.init()
        self.cellId = cellId
        self.obj = obj
    }
}


class Time: Comparable, Equatable {
    init(_ date: Date) {
        //get the current calender
        let calendar = Calendar.current
        
        //get just the minute and the hour of the day passed to it
        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        
        //calculate the seconds since the beggining of the day for comparisions
        let dateSeconds = dateComponents.hour! * 3600 + dateComponents.minute! * 60
        
        //set the varibles
        secondsSinceBeginningOfDay = dateSeconds
        hour = dateComponents.hour!
        minute = dateComponents.minute!
    }
    
    init(_ hour: Int, _ minute: Int) {
        //calculate the seconds since the beggining of the day for comparisions
        let dateSeconds = hour * 3600 + minute * 60
        
        //set the varibles
        secondsSinceBeginningOfDay = dateSeconds
        self.hour = hour
        self.minute = minute
    }
    
    var hour : Int
    var minute: Int
    
    var date: Date {
        //get the current calender
        let calendar = Calendar.current
        
        //create a new date components.
        var dateComponents = DateComponents()
        
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        return calendar.date(byAdding: dateComponents, to: Date())!
    }
    
    /// the number or seconds since the beggining of the day, this is used for comparisions
    private let secondsSinceBeginningOfDay: Int
    
    //comparisions so you can compare times
    static func == (lhs: Time, rhs: Time) -> Bool {
        return lhs.secondsSinceBeginningOfDay == rhs.secondsSinceBeginningOfDay
    }
    
    static func < (lhs: Time, rhs: Time) -> Bool {
        return lhs.secondsSinceBeginningOfDay < rhs.secondsSinceBeginningOfDay
    }
    
    static func <= (lhs: Time, rhs: Time) -> Bool {
        return lhs.secondsSinceBeginningOfDay <= rhs.secondsSinceBeginningOfDay
    }
    
    
    static func >= (lhs: Time, rhs: Time) -> Bool {
        return lhs.secondsSinceBeginningOfDay >= rhs.secondsSinceBeginningOfDay
    }
    
    
    static func > (lhs: Time, rhs: Time) -> Bool {
        return lhs.secondsSinceBeginningOfDay > rhs.secondsSinceBeginningOfDay
    }
}
extension Date {
    var time: Time {
        return Time(self)
    }
}


typealias GradientType = (x: CGPoint, y: CGPoint)



enum GradientPoint {
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    case topRightBottomLeft
    case bottomLeftTopRight
    
    func draw() -> GradientType {
        switch self {
        case .leftRight:
            return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
        case .topRightBottomLeft:
            return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
        }
    }
}





extension UIDevice {
    
    private struct InterfaceNames {
        static let wifi = ["en0"]
        static let wired = ["en2", "en3", "en4"]
        static let cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
        static let supported = wifi + wired + cellular
    }
    
   
    func ipAddress() -> String? {
        var ipAddress: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var pointer = ifaddr
            
            while pointer != nil {
                defer { pointer = pointer?.pointee.ifa_next }
                
                guard
                    let interface = pointer?.pointee,
                    interface.ifa_addr.pointee.sa_family == UInt8(AF_INET) || interface.ifa_addr.pointee.sa_family == UInt8(AF_INET6),
                    let interfaceName = interface.ifa_name,
                    let interfaceNameFormatted = String(cString: interfaceName, encoding: .utf8),
                    InterfaceNames.supported.contains(interfaceNameFormatted)
                    else { continue }
                
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                
                getnameinfo(interface.ifa_addr,
                            socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname,
                            socklen_t(hostname.count),
                            nil,
                            socklen_t(0),
                            NI_NUMERICHOST)
                
                guard
                    let formattedIpAddress = String(cString: hostname, encoding: .utf8),
                    !formattedIpAddress.isEmpty
                    else { continue }
                
                ipAddress = formattedIpAddress
                break
            }
            
            freeifaddrs(ifaddr)
        }
        
        return ipAddress
    }
    
}
