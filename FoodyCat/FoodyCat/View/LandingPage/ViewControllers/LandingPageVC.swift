//
//  LandingPageVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 09/12/2021.
//

import UIKit

class LandingPageVC: UIViewController {

    @IBOutlet weak var backgroundView: GradientView!
    override func viewDidLoad() {
        super.viewDidLoad()
        routeViewController()
        // Do any additional setup after loading the view.
    }

    func routeViewController() {
        //if SharedData.SharedInstans.GetIsLogin() {
            guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootViewController else {return}
            UIApplication.shared.windows.first?.rootViewController = homeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()


//        guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "GetUserLocationVC") as? GetUserLocationVC else {return}
//        UIApplication.shared.windows.first?.rootViewController = homeVC
//        UIApplication.shared.windows.first?.makeKeyAndVisible()

//        } else{
//            guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as? SignInVC else {return}
//            UIApplication.shared.windows.first?.rootViewController = homeVC
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
        //}
    }
}
