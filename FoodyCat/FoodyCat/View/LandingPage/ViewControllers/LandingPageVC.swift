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
        if SharedData.SharedInstans.getIsFinishOnboarding() {
            if SharedData.SharedInstans.GetShowMap() {
                guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {return}
                UIApplication.shared.windows.first?.rootViewController = homeVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                guard let homeVC = UIStoryboard.init(name:"Home", bundle: nil).instantiateViewController(withIdentifier: "GetUserLocationVC") as? GetUserLocationVC else {return}
                UIApplication.shared.windows.first?.rootViewController = homeVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }

        } else {
            guard let homeVC = UIStoryboard.init(name:"Auth", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC") as? OnboardingVC else {return}
            UIApplication.shared.windows.first?.rootViewController = homeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
