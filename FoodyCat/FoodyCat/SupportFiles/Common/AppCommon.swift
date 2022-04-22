//
//  AppCommon.swift
//  AshakAlena
//
//  Created by Mohammad Farhan on 22/12/176/8/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import UIKit
import  SwiftyJSON
import Kingfisher
import StoreKit
import Alamofire
import NotificationBannerSwift
//import JBWebViewController
//import SwiftyJSON
//import FirebaseAnalytics

class AppCommon: UIViewController {
    
    static let sharedInstance = AppCommon()
    
    
    func LoadStaticMapImage(lat: String, Long: String,MapImageView:UIImageView)
    {
        let Lat = lat
        let Lng = Long
        
        let mapul = "https://maps.google.com/maps/api/staticmap?key=\(AppConstant.Google.GOOGLE_MAP_API)&markers=color:green|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(MapImageView.frame.size.width))x\(2 * Int(MapImageView.frame.size.height))")&sensor=true&fbclid=IwAR2rsCS0d9D-aow4D3AWs9-fv3EdiSDsFFUU80Gm6oQ7vCZwlXUaPjUOmU8"
        
        let urlI = URL(string: mapul.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        if let url = urlI {
            print("map: \(urlI!)")
            
            MapImageView.kf.indicatorType = .activity
            MapImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "Apple_Maps_01302020_LP_hero.jpg.og"),
                options: [.transition(.fade(1))
                          
                ])
            {
                result in
                
            }
        } else{
            print("nil")
        }
    }
    
    func dismissLoader(_ view:UIView){
        view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    
    func roundingUIView( _ aView: UIView!,  cornerRadiusParam: CGFloat!) {
        aView.layer.cornerRadius = cornerRadiusParam
        aView.clipsToBounds = true
    }
    
    
    func saveJSON(json: JSON, key:String){
        let jsonString = json.rawString()!
        UserDefaults.standard.setValue(jsonString, forKey: key)
        //            UserDefaults.synchronize()
    }
    
    func getJSON(_ key: String)->JSON {
        var p = ""
        if let buildNumber = UserDefaults.standard.value(forKey: key) as? String {
            p = buildNumber
        }else {
            p = ""
        }
        if  p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                return try! JSON(data: json)
            } else {
                return JSON("nil")
            }
        } else {
            return JSON("nil")
        }
    }
    

    func isValidEmail(txtString:String) -> Bool {
        let emailRegEx = "^([0-9]{8})|[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: txtString)
    }
    
    func showlogin(vc: UIViewController) {
        //        let sb = UIStoryboard(name: "AuthStoryboard", bundle: nil)
        //        let controller = sb.instantiateViewController(withIdentifier: "LoginVCViewController") as! LoginVCViewController
        //    vc.show(controller, sender: true)
        
    }
    
    
    
    
    
    func alert(title: String, message: String, controller: UIViewController, actionTitle: String, actionStyle: UIAlertAction.Style) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: nil))
        alert.view.tintColor = UIColor.hexColor(string: "023f82")

        controller.present(alert, animated: true, completion: nil)
        
    }
    
    
    func alertWith(title: String, message: String, controller: UIViewController, actionTitle: String, actionStyle: UIAlertAction.Style, withCancelAction: Bool, completion: @escaping () -> Void) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: { (action) in
            completion()
        }))
        alert.view.tintColor = UIColor.hexColor(string: "023f82")
        if withCancelAction {
            alert.addAction(UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: .cancel, handler: nil))
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    
    func NotFound(_ view:UITableView! , Msg:String? , Count:Int){
        if(Count <= 0){
            let  notFound: UILabel = UILabel()
            notFound.text = Msg
            notFound.font = UIFont(name: "HacenTunisiaBd", size: 12)
            notFound.numberOfLines = 2
            notFound.textAlignment = NSTextAlignment.center
            view.backgroundView = notFound
            view.separatorStyle=UITableViewCell.SeparatorStyle.none
            
        }else{
            let  notFound: UILabel = UILabel()
            notFound.text = ""
            notFound.textAlignment = NSTextAlignment.center
            view.backgroundView = notFound
            view.separatorStyle=UITableViewCell.SeparatorStyle.none
        }
        
    }
    
    func textInView(_ view:UIView! , Msg:String?,size: CGFloat,txtColor: UIColor){
        let  notFound: UILabel = UILabel()
        notFound.text = Msg
        notFound.font = UIFont(name: "HacenTunisiaBd", size: size)
        notFound.textColor = txtColor
        notFound.textAlignment = NSTextAlignment.center
        notFound.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(notFound)
    }
    
    
    func Alert(_ Message:String?,Title:String?,BtnOk:String?,Context:AnyObject ,Actions:@escaping ()->Void?){
        let WrongAlert=UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        WrongAlert.addAction(UIAlertAction(title: BtnOk, style: UIAlertAction.Style.default, handler: { Action in
            Actions()
        }))
        Context.present(WrongAlert, animated: true, completion: nil)
    }
    
    func ShowLoader(_ view:UIView,color:UIColor){
        let Loader  = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        Loader.backgroundColor = color
        Loader.tag = 1000
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        loadingIndicator.center = Loader.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.color = UIColor.darkGreyBlue
        loadingIndicator.startAnimating();
        Loader.addSubview(loadingIndicator)
        view.addSubview(Loader)
    }
    
    
    
    
    func localization(_ key:String)->String {
        let lang = SharedData.SharedInstans.getLanguage()
        
        if let path = Bundle.main.path(forResource: "lang-\(lang)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                //                let jsonObj = JSON(data: data)
                let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                //                print(jsonDic!["couponNumber"]!)
                //                print("jsonData:\(jsonDic!)")
                if jsonDic![key] != nil {
                    return jsonDic![key] as! String
                }
                if !(jsonDic?.isEmpty)! {
                    //                    print("jsonData:\(jsonObj)")
                    return "_"+key
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                    return "_"+key
                    
                }
            } catch let error {
                print(error.localizedDescription)
                return "_"+key
                
            }
        } else {
            print("Invalid filename/path.")
            return "_"+key
            
        }
        
    }
    
    func openLink(Url:String){
        
        let webURL = URL(string:Url)!
        
        
        UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        
    }
    
    func ShareLink(Url:String,vc: UIViewController){
        if let name = URL(string: Url), !name.absoluteString.isEmpty {
            let objectsToShare = [name]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            vc.present(activityVC, animated: true, completion: nil)
        }else  {
            // show alert for not available
        }
    }
//    func resetRootHome() {
//        if SharedData.SharedInstans.GetIsLogin() {
//            RootHome()
//        }else{
//            if SharedData.SharedInstans.getCartID() != "nil"
//            {
//                RootHome()
//            }else{
//                resetRootLogin()
//            }
//
//        }
//
//
//    }
//    func restartApplication () {
//        guard let rootVC = UIStoryboard.init(name:"LandScreen", bundle: nil).instantiateViewController(withIdentifier: "LandScreenVC") as? LandScreenVC else {
//            return
//        }
//        
//        UIApplication.shared.windows.first?.rootViewController = rootVC
//        
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    
//    }

    func resetRootIntro() {
        guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {return}
        UIApplication.shared.windows.first?.rootViewController = homeVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()

    }
    func showBanner(title:String,subtitle:String = "",style:BannerStyle,customColor:UIColor? = nil) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        if customColor != nil {
            banner.backgroundColor = customColor
        }
        banner.show()
        
    }
    
//    func resetRootIntro() {
//
//        guard let rootVC =  UIStoryboard.init(name:"Intro", bundle: nil).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC else {
//            print(123)
//            return
//
//        }
//
//        guard let nvc = UIStoryboard.init(name:"Intro", bundle: nil).instantiateViewController(withIdentifier: "IntroNav") as? UINavigationController else {
//            return
//        }
//
//        nvc.viewControllers = [rootVC]
//
//        UIApplication.shared.windows.first?.rootViewController = nvc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//
//    }
    
//    func resetRootLogin() {
//        guard let rootVC =  UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "IntroAuthVC") as? IntroAuthVC else {
//            print(123)
//            return
//
//        }
//        guard let nvc = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as? UINavigationController else {
//            return
//        }
//
//        nvc.viewControllers = [rootVC]
//
//        UIApplication.shared.windows.first?.rootViewController = nvc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
    
//    func showSuccessPage() {
//        guard let rootVC =  UIStoryboard.init(name:"SuccessPage", bundle: nil).instantiateViewController(withIdentifier: "SuccessPageVC") as? SuccessPageVC else {
//            print(123)
//            return
//
//        }
//        guard let nvc = UIStoryboard.init(name:"SuccessPage", bundle: nil).instantiateViewController(withIdentifier: "successNavBar") as? UINavigationController else {
//            return
//        }
//
//        nvc.viewControllers = [rootVC]
//
//        UIApplication.shared.windows.first?.rootViewController = nvc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
    func getHeader(AddtionParms:HTTPHeaders)->HTTPHeaders
    {
        var newParam = AddtionParms
        //let playerId = UserDefaults.standard.string(forKey: "GT_PLAYER_ID") ?? ""
        newParam["Content-Type"] = "application/json;charset=utf-8"
        newParam["device"] = "1"
        newParam["lang"] = "0"
        //newParam["playerid"] = playerId
        
        if SharedData.SharedInstans.GetIsLogin(){
            newParam["Authorization"] = "bearer \(SharedData.SharedInstans.gettoken())"
        }
        
        return  newParam
    }
    func multiPartHeader(AddtionParms:[String:String])->[String:String]
    {
        var newParam = AddtionParms
        
        newParam["Content-type"] = "multipart/form-data"
        
        if SharedData.SharedInstans.GetIsLogin(){
            newParam["Authorization"] = "bearer \(SharedData.SharedInstans.gettoken())"
        }
        
        return  newParam
    }
   
    
    
   
    func getAdminHeader(AddtionParms:[String:String])->[String:String]
    {
        var newParam = AddtionParms
        newParam["Content-Type"] = "application/json;charset=utf-8"
        
        newParam["Authorization"] = "bearer Iyk6owkum4oonpnlztj9voickdmcjbr6"
//         newParam["Authorization"] = "bearer qpefu53fzyep7au8krjl7kdsfiw7t1l8"
        return  newParam
    }
    
   
    
    
    
    func MoveTOViewController( ViewControllerFrom:UIViewController,StoryBoard:AppStoryboard , ViewController:UIViewController , ispush:Bool = true)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: StoryBoard.rawValue, bundle:nil)
        let VC = ViewController
        //            storyBoard.instantiateViewController(withIdentifier: ViewController)
        if ispush == true
        {
            ViewControllerFrom.navigationController?.pushViewController(VC, animated: true)
        }else{
            ViewControllerFrom.present(VC, animated: true, completion: nil)
        }
        
    }
    
    // use to change item postion  in array
    
    func Rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        
        return arr
    }
    
    func getlastVC()->UIViewController?{
        
        if let navigationController = UIApplication.topViewController()?.navigationController {
            
            let viewControllers: [UIViewController] = (navigationController.viewControllers) as [UIViewController]
            
            let VC = viewControllers.last
            
            return VC
            
        }
        return nil
        
    }
//    func LoginForGuest(){
//
//        let alert = UIAlertController(title: "you need to Log In".localized(), message: "",preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "no".localized(), style: UIAlertAction.Style.default, handler: { _ in
//            //Cancel Action
//            self.getlastVC()?.tabBarController?.selectedIndex = 0
//
//        }))
//        alert.addAction(UIAlertAction(title: "yes".localized(),
//                                      style: UIAlertAction.Style.cancel,
//                                      handler: {(_: UIAlertAction!) in
//                                        SharedData.SharedInstans.removeUserData()
//                                        self.resetRootLogin()
//                                      }))
//        self.getlastVC()?.present(alert, animated: true, completion: nil)
//    }
    
//    func verifyLogin(){
//        if let lastVC = self.getlastVC() {
//        let alert = UIAlertController(title: "you need to Log In".localized(), message: "",preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "no".localized(), style: UIAlertAction.Style.default, handler: { _ in
//            //Cancel Action
//
//
//        }))
//        alert.addAction(UIAlertAction(title: "yes".localized(),
//                                      style: UIAlertAction.Style.cancel,
//                                      handler: {(_: UIAlertAction!) in
//                                        SharedData.SharedInstans.removeUserData()
//                                        self.resetRootLogin()
//                                      }))
//            lastVC.present(alert, animated: true, completion: nil)
//        }
//    }
//
   
   
   
    
    static let minimumReviewWorthyActionCount = 3
    
    func rateApp() {
        
      
                SKStoreReviewController.requestReview()

        
    }
    
  
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    
}

