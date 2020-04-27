//
//  AppCoordinator.swift
//  HealthProfiler
//

import Foundation
import UIKit

class AppCoordinator {
    
    //
    public static let shared = AppCoordinator()
    
    public var rootContainer: AppContainer?
    public var rootNavigationController: UINavigationController?
    public var tabBarController: UITabBarController?
    
    /*
     
     */
    func getRootContainer() -> AppContainer? {
        
        rootNavigationController = UINavigationController(rootViewController: LoginViewController.nibInstance())
        rootNavigationController?.isNavigationBarHidden = true
        rootContainer = AppContainer(rootNavigationController!)
        
        return rootContainer
    }
    
    /*
     
     */
    func getDashboard() -> DrawerWrapper {
        
        //create new UITabBarController
        let home = navigationController(HomeViewController.nibInstance(), tabTitle: "Home", tabIcon: "Hamburger")
        let healthProfile = navigationController(HealthProfileViewController.nibInstance(), tabTitle: "Health Profile", tabIcon: "Hamburger")
        let coverage = navigationController(CoverageViewController.nibInstance(), tabTitle: "Coverage", tabIcon: "Hamburger")
        let manageConnections = navigationController(ManageConnectionsViewController.nibInstance(), tabTitle: "Manage Connections", tabIcon: "Hamburger")
        
        tabBarController = UITabBarController()
        tabBarController?.viewControllers = [home,healthProfile, coverage, manageConnections]
        
        let menu = MenuViewController.nibInstance()
        return DrawerWrapper(tabBarController!, leftVC: menu)
    }
    
    /*
    
    */
    func logout() {
        
        //remove any saved data
        
        //navigate to login screen
        if let navController = rootNavigationController {
            
            if let container = rootContainer {
                container.showBrandingBar(false)
            }
            
            navController.popToRootViewController(animated: true)
            
            //reset tabBarController
            tabBarController = nil
        }
    }
}



private extension AppCoordinator {
    
    /*
     
     */
    private func navigationController(_ rootController: UIViewController,
                                      tabTitle: String,
                                      tabIcon: String) -> UINavigationController {
        
        rootController.tabBarItem = UITabBarItem.init(title: tabTitle,
                                                      image: UIImage(named: tabIcon),
                                                      selectedImage: UIImage(named: tabIcon))
        rootController.navigationItem.title = tabTitle
        rootController.addDrawerButton()
        return UINavigationController(rootViewController: rootController)
    }
}
