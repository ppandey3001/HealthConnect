//
//  TabBarCoordinator.swift
//  HealthProfiler
//

import Foundation
import UIKit

class TabBarCoordinator {
    
    //
    public static let shared = TabBarCoordinator()
    
    public var tabBarController: UITabBarController?

    /*
     
     */
    func getTabBar() -> UITabBarController {
        
        //create new UITabBarController
        let home = navigationController(HomeViewController.nibInstance(), tabTitle: "Home", tabIcon: "Hamburger")
        let healthProfile = navigationController(HealthProfileViewController.nibInstance(), tabTitle: "Health Profile", tabIcon: "Hamburger")
        let coverage = navigationController(CoverageViewController.nibInstance(), tabTitle: "Coverage", tabIcon: "Hamburger")
        let manageConnections = navigationController(ManageConnectionsViewController.nibInstance(), tabTitle: "Manage Connections", tabIcon: "Hamburger")
        
        tabBarController = UITabBarController()
        tabBarController?.viewControllers = [home,healthProfile, coverage, manageConnections]
        
        return tabBarController!
    }
    
    func getNavigationIndex(type: HPMenuItemType) -> Int {
        
        switch type {
        case .home:
            return HPTabType.home.tabIndex
            
        case .coverage:
            return HPTabType.coverage.tabIndex
            
        case .manageConnections:
            return HPTabType.manageConnections.tabIndex
            
        default:
            return tabBarController?.selectedIndex ?? 0
        }
    }
}


private extension TabBarCoordinator {
    
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
