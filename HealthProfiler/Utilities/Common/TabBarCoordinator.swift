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
//        let myProfile = navigationController(ProfileViewController.nibInstance(), tabTitle: "Profile", tabIcon: UIImage.tabIcon_coverage())

        tabBarController = UITabBarController()
        tabBarController?.viewControllers = [home,healthProfile, coverage, manageConnections]
        return tabBarController!
    }
    
    func tabBarStatus(isUserConnected: Bool) {
        
        if let items = tabBarController?.tabBar.items {
            
            if HealthProfiler.shared.loggedInUser?.isFirstTimeUser ?? false {
                let item = items[0]
                item.isEnabled = false
                for index in 0...(items.count - 2) {
                    let itemToDisable = items[index]
                    if index == 2 {
                        itemToDisable.isEnabled = HealthProfiler.shared.loggedInUser?.isInsurerConnected ?? false
                    } else if index == 1 {
                        itemToDisable.isEnabled = isUserConnected
                    }
                }
            } else {
                
                for index in 0...(items.count - 2) {
                    
                    let itemToDisable = items[index]
                    itemToDisable.isEnabled = isUserConnected
                }
            }
        }
    }
    func tabTitle() {
        if let items = self.tabBarController?.tabBar.items {
                 // in each item we have a view where we find 2 subviews imageview and label
                 // in this example i would like to change
                      // access to item view
                     let viewTabBar = items[2].value(forKey: "view") as? UIView
                   // access to item subviews : imageview and label
            if viewTabBar?.subviews.count == 2 {
                       let label = viewTabBar?.subviews[1]as? UILabel
                     // here is the customization for my label 2 lines
                       label?.numberOfLines = 2
                       label?.textAlignment = .center
                       label!.text = "tab_point"
                       // here customisation for image insets top and bottom
                       items[2].imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -5, right: 0)
                       }
                       }
    }
    
    
    func getNavigationIndex(type: HPMenuItemType) -> Int {
        
        switch type {
           
        case .coverage:
            return HPTabType.coverage.tabIndex
            
        case .manageConnections:
            return HPTabType.manageConnections.tabIndex
            
//        case .myProfile:
//            return HPTabType.myProfile.tabIndex
            
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
//        if let user = HealthProfiler.shared.loggedInUser,
//            let name = user.name, let age = user.age, let gender = user.gender {
////            rootController.navigationItem.title = HealthProfiler.shared.loggedInUser?.isFirstTimeUser ?? false ? "\(name)" : "\(name)  |  \(age) Y  | \(gender)"
//        }
        rootController.navigationItem.title = tabTitle
        rootController.addDrawerButton()
//        rootController.addProfileButton()
        return UINavigationController(rootViewController: rootController)
    }
}
