//
//  StartupManager.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/19/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit
//import Localize_Swift
//import Reachability
//import OneSignal
//import GooglePlaces
//import GoogleMaps
//import FacebookCore

import UserNotifications
class StartupManager: NSObject {
    var timer:Timer?
    var timeLeft = 100
    let current = UNUserNotificationCenter.current()
    
    static let sharedInstance = StartupManager();
    let userDefaults = UserDefaults.standard
    
   
    
    //MARK:- Methods
    
    
       
    func initNavbar(){
    
            UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.white
              UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
               UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
   
    
    func getCurrentTimesOfOpenApp() -> Int {
        return userDefaults.integer(forKey: "timesOfOpenApp") + 1
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    func getApiToken(){
        
    }
    func GetDeviceAPi(){
        
        
        
    }
    @objc func openAuthentication(){
        //        APIClient.Auth.getCurrentUser { (user) in
        //            if let user = user {
        //                user.token = User.currentUser.token
        //                User.currentUser.saveObj(user: user)
        //            }
        //        }
    }
    func initGoogleMap(){
//        GMSServices.provideAPIKey(AppConstant.Google.GOOGLE_MAP_API)
//        GMSPlacesClient.provideAPIKey(AppConstant.Google.GOOGLE_MAP_API)
        
    }
  
    
    func handleNetworkChange(isOn:Bool){
        if isOn{
            print("network is on")
       
          closeNoNetworkPopup()
                  
        }else {
            print("network is off")
            openNoNetworkPopup()
        }
    }
    func openHome(){
//           if let vc = UIViewController.storyboardViewController(storyBoardName:.main, identifier: "HomeTapBarVC"){
//               setRootViewController(vc: vc)
//           }
       }
    func openNoNetworkPopup(){
//        BannerView.showAlert(message: "Please check your internet connection".localized(), colorCode: BannerColorCode.failure,isChecknet: true)
    }
    func closeNoNetworkPopup(){

//        BannerView.showAlert(message: "internet connection".localized(), colorCode: BannerColorCode.success)
    }
    
    
    
    func resetRootHome() {
//        guard let rootVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTapBarVC") as? HomeTapBarVC else {
//            return
        }
//        let navigationController = UINavigationController(rootViewController: rootVC)
//
//        UIApplication.shared.windows.first?.rootViewController = rootVC
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    func resetRootLogin() {
//        guard let rootVC = UIStoryboard.init(name:"AuthStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LoginVCViewController") as? LoginVCViewController else {
//            return
//        }
//        guard let nvc = UIStoryboard.init(name:"AuthStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as? UINavigationController else {
//            return
//        }
//        
//        nvc.viewControllers = [rootVC]
//        
//        UIApplication.shared.windows.first?.rootViewController = nvc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
   
    func openNotConnectVIew(VC:UIViewController){
//           if let vc = UIViewController.storyboardViewController(storyBoardName: .main, identifier: "InternetNotConncetVC"){
//            VC.modalPresentationStyle = .fullScreen
//            VC.show(vc, sender: (Any).self)
//           }
       }
    
    
    func getMyData(){
        
    }
    func handleLogin(){
        //        getMyData()
        //        if User.currentUser.isLoggedIn() {
//        openHome()
        //        }else {
        //            openIntro()
        //        }
    }
    func signout(){
        //
        //        if let user = User(JSON: [:]){
        ////            APIClient.getApiToken { (token) in
        //                User.currentUser.saveObj(user: user)
        //                UserDefaults.standard.removeObject(forKey: "user_id")
        //                StartupManager.sharedInstance.handleLogin()
        ////            }
        //        }
        //        openLogin()
    }
    func openIntro(){
//        let vc = UIViewController.storyboardNavigationController(storyBoardName: .registeration, identifier: "IntroNVC")
//        setRootViewController(vc: vc)
    }
    func openLogin () {
//        let vc = UIViewController.storyboardNavigationController(storyBoardName: .registeration, identifier: "SignInVC")
//        setRootViewController(vc: vc)
    }
    func openRegister () {
//        //        let story  = UIStoryboard.init(name: "Authentication", bundle: nil)
//        //        let nav = story.instantiateViewController(withIdentifier: "IntroNVC") as? UINavigationController
//        //        let vc = nav?.viewControllers.first as? IntroVC
//        let vc = UIViewController.storyboardNavigationController(storyBoardName: .registeration, identifier: "IntroNVC")
//        //     vc?.shouldScrollToLogin = true
//        setRootViewController(vc: vc)
    }
    func setRootViewController (vc:UIViewController){
//        AppDelegate.getIntance().window?.rootViewController = vc
//        AppDelegate.getIntance().window?.makeKeyAndVisible()
    }



enum HomeTabs : NSInteger {
    case search
    case navigation
    case favorite
    case setting
}

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
