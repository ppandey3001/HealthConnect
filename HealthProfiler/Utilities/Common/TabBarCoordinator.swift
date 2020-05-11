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
    
    let user = UserDefaults.standard.string(forKey: "name")


    //marking init() as 'private' will disallow to create any other object of the class
    private init() { }
    
    /*
     
     */
    func getTabBar() -> UITabBarController {
        
        //create new UITabBarController
        let home = navigationController(HomeViewController.nibInstance(), tabTitle: "Home", tabIcon: UIImage.tabIcon_home())
        let healthProfile = navigationController(HealthProfileViewController.nibInstance(), tabTitle: "Health Profile", tabIcon: UIImage.tabIcon_healthProfile())
        let coverage = navigationController(CoverageViewController.nibInstance(), tabTitle: "Coverage", tabIcon: UIImage.tabIcon_coverage())
        let manageConnections = navigationController(ManageConnectionsViewController.nibInstance(), tabTitle: "Manage Connections", tabIcon: UIImage.tabIcon_manageConnections())
        
        tabBarController = UITabBarController()
        tabBarController?.viewControllers = [home,healthProfile, coverage, manageConnections]
//        tabBarController?.selectedIndex = (user == "wilma") ? 3 : 0
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
                                      tabIcon: UIImage?) -> UINavigationController {
        
        rootController.tabBarItem = UITabBarItem.init(title: tabTitle,
                                                      image: tabIcon,
                                                      selectedImage: tabIcon)
        if let user = HealthProfiler.shared.loggedInUser,
            let name = user.name, let age = user.age {
            rootController.navigationItem.title = "\(name)  |  \(age) Years"
        }
        rootController.addDrawerButton()
        rootController.addProfileButton()
        return UINavigationController(rootViewController: rootController)
    }
}
