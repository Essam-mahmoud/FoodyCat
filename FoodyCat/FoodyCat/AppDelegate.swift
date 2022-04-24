//
//  AppDelegate.swift
//  FoodyCat
//
//  Created by Essam Orabi on 09/12/2021.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import OneSignal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        GMSPlacesClient.provideAPIKey("AIzaSyC5OOPpGCZCZtJ4VPdo9T4YciFg-Tv6EWc")
        GMSServices.provideAPIKey("AIzaSyC5OOPpGCZCZtJ4VPdo9T4YciFg-Tv6EWc")
        IQKeyboardManager.shared.enable = true

        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("6b0d8846-d1c3-49ef-9902-72320331df11")
        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {return}
        UIApplication.shared.windows.first?.rootViewController = homeVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()

        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    // MARK: UISceneSession Lifecycle
// API_KEY = AIzaSyC5OOPpGCZCZtJ4VPdo9T4YciFg-Tv6EWc
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    private func setupNotification(application: UIApplication){
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()

    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    class func getIntance()->AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }


}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        print(userInfo)
//        guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootViewController else {return}
//        UIApplication.shared.windows.first?.rootViewController = homeVC
//        UIApplication.shared.windows.first?.makeKeyAndVisible()


        // Change this to your preferred  presentation option
        completionHandler([.alert, .badge, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        // Print message ID.
        //let userInfo = response.notification.request.content.userInfo
        // Print message ID.

        completionHandler()
    }
}

