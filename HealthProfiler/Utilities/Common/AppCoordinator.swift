//
//  AppCoordinator.swift
//  HealthProfiler
//

import Foundation
import UIKit

class AppCoordinator {
    
    //
    public static let shared = AppCoordinator()
    
    public var rootNavigationController: UINavigationController?
    
    //marking init() as 'private' will disallow to create any other object of the class
    private init() { }
    
    /*
     
     */
    func getRootContainer() -> UINavigationController? {
        
        rootNavigationController = UINavigationController(rootViewController: LoginViewController.nibInstance())
        rootNavigationController?.isNavigationBarHidden = true

        return rootNavigationController
    }
    
    /*
     
     */
    func getDashboard() -> DrawerWrapper {
        
        //get new UITabBarController
        let tabBarController = TabBarCoordinator.shared.getTabBar()
        
        let menu = MenuViewController.nibInstance()
        
        return DrawerWrapper(tabBarController, leftVC: menu)
    }
    
    /*
    
    */
    func logout() {
        
        //remove any saved data
        
        //navigate to login screen
        if let navController = rootNavigationController {
            
            navController.popToRootViewController(animated: false)
            
            //reset tabBarController
            TabBarCoordinator.shared.tabBarController = nil
        }
    }
}


private extension AppCoordinator {
    
   
}
