//////
//////  NotificationManager.swift
//////  Duty
//////
//////  Created by Mohamed Ismail on 6/10/18.
//////  Copyright © 2018 GreenTech. All rights reserved.
//////
////
//import UIKit
//import UserNotifications
//import AVFoundation
//import Firebase
//import FirebaseMessaging
//import FirebaseCore
//
//var comefromNotification = false
//var NOtifiactionContent_id = 0
//var NOtifiactionClick_action = ""
//enum NotificationType :String {
//    case refreshPRoductDetails =  "refreshPRoductDetails"
//    case locationPermissionGranted = "locationPermissionGranted"
//    case refreshProfileData = "refreshProfileData"
//    case refreshMyList = "refreshMyList"
//    case refrestTasks = "refrestTasks"
//}
//
//class NotificationManager: NSObject , MessagingDelegate {
//    static let sharedInstance = NotificationManager()
//
//
//
//
//
//
//
//    /// used for saving gcm notification id that was handled before
//    var recievedNotificaiton = JSONAlis()
//
//    var token :String {
//        get{
//            return UserDefaults.standard.string(forKey: "push_token") ?? "12333333333"
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "push_token")
//        }
//    }
//
//
//    var udidKey :String {
//        get{
//            return UserDefaults.standard.string(forKey: "udidKey") ?? ""
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "udidKey")
//        }
//    }
//
//    func postNotification(type:NotificationType,obj:JSONAlis?){
////        if ![NotificationType.refreshProfileData,NotificationType.locationPermissionGranted].contains(type) && User.currentUser.isLoggedIn(){
//            NotificationCenter.default.post(name: NSNotification.Name.init(type.rawValue), object: nil, userInfo: obj)
//
////        }
//    }
//    func observe(type:NotificationType,onAction:@escaping((Notification)-> Void)){
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(type.rawValue), object: nil, queue: nil, using: {onAction($0)})
//    }
//
//
//    //MARK:- Methods
//    func run(){
//
//        NotificationManager.sharedInstance.registerPushNotificationNotification()
//
//    }
//
//
//    private  func registerPushNotificationNotification(){
//          FirebaseApp.configure()
//
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = NotificationManager.sharedInstance
//
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//        }
//
//        UIApplication.shared.registerForRemoteNotifications()
//
//        SetFCMToken()
//
//
//
//    }
//
//    func SetFCMToken() {
//        Messaging.messaging().delegate = self
//               let tokenfcm = Messaging.messaging().fcmToken
//               print("FCM token: \(tokenfcm ?? "")")
//               token = tokenfcm ?? ""
//
//                udidKey = UIDevice.current.identifierForVendor!.uuidString
//
//               print("udidKey: \(udidKey)")
//
//    }
//    func handleNotification(notification :Notification?){
//
//        print(123)
//    }
//    func handleIncommingNotification(data:JSONAlis){
//        print("incomming push notification", data)
//
//
//              let aps = data["aps"] as! JSONAlis
//             let content_id = data["content_id"] as? String ?? ""
//              let category = aps["category"] as? String ?? ""
//
//
////        if User.currentUser.isLoggedIn()
////        {
////
//                         print(category,content_id)
//             comefromNotification = true
//            NOtifiactionClick_action = category
//            NOtifiactionContent_id = Int(content_id) ?? 0
//            StartupManager.sharedInstance.openHome()
////        }
////            else {
////            print("but user is not logged in so will drop it")
////            return
////        }
//
//    }
//
//    func handleTappedNotification(data:JSONAlis){
//
//
//              let aps = data["aps"] as! JSONAlis
//             let content_id = data["content_id"] as? String ?? ""
//              let category = aps["category"] as? String ?? ""
//
//
////        if User.currentUser.isLoggedIn()
////        {
////
////                         print(category,content_id)
////             comefromNotification = true
////            NOtifiactionClick_action = category
////            NOtifiactionContent_id = Int(content_id) ?? 0
////            StartupManager.sharedInstance.openHome()
////        }
////            else {
////            print("but user is not logged in so will drop it")
////            return
////        }
//
//    }
//
//
//}
//
//extension NotificationManager : UNUserNotificationCenterDelegate{
//
//
//  }
//
//      func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        let userInfo = response.notification.request.content.userInfo
//               print(userInfo)
//
//    }
//
//
//     func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//         let userInfo:[AnyHashable:Any] =  notification.request.content.userInfo
//
//         completionHandler([.alert,.badge,.sound])
//        print(userInfo)
//
//    }
////
////
////
////
////
