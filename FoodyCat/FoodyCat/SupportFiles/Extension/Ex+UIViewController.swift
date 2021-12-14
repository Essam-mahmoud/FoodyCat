//
//  Ex+UIViewController.swift
//  DAWAA
//
//  Created by taha hamdi on 6/24/20.
//  Copyright © 2020 taha hamdi. All rights reserved.
//

import UIKit
extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    //show side menu from any view controller
    func showNavigationDrawerFromViewController()  {
       
    }
    
    //hide side menu from any view controller
    func hideDrawerControllerFromViewController()  {
        
    }
    
    
    //hide side menue when click on header icon
    func hideDrawerControllerFromSideMenu()   {
       
    }
    
    //show view controller when select from form side menu
    func pushViewControllerFromSideMenu(viewController:UIViewController)  {
        
    }
//       func pushViewControllerFromSideMenu_SWreveal(viewController:UIViewController)  {
//        if let navigationController = (parent as? SWRevealViewController)?.frontViewController as? UINavigationController{
//            if let vc = self.revealViewController()   {
//                if viewController != SideMenuViewController(){
//                    vc.revealToggle(animated: true)
//                }
////                let navController = UINavigationController(rootViewController: viewController)
//                navigationController.pushViewController(viewController, animated: true)
//            }
//        }
//    }
    
//    func presentViewControllerFromSideMenu_SWreveal(viewController:UIViewController)  {
//        if let navigationController = (parent as? SWRevealViewController)?.frontViewController as? UINavigationController{
//            if let vc = self.revealViewController()   {
//                if viewController != SideMenuViewController(){
//                    vc.revealToggle(animated: true)
//                }
//                navigationController.present(viewController, animated: true)
//            }
//        }
//    }
    
    func presentViewControllerFromSideMenu(viewController:UIViewController)  {
//        if let navigationController = (parent as? KYDrawerController)?.mainViewController as? UINavigationController{
//            hideDrawerControllerFromSideMenu()
//            navigationController.present(viewController, animated: true)
//        }
    }
}
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
