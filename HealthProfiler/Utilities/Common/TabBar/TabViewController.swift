//
//  TabViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 10/07/20.
//  Copyright © 2020 UHG. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var contentView : UIView!
    
    var manageConnection : UINavigationController!
    var coverage : UINavigationController!
    var viewConntrollers : [UIViewController]!
    
    var selectedIndex : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        getTabBar()

        // Do any additional setup after loading the view.
    }

        func getTabBar(){
            
            //create new UITabBarController
//            let home = navigationController(HomeViewController.nibInstance(), tabTitle: "Home", tabIcon: UIImage.tabIcon_home())
//            let healthProfile = navigationController(HealthProfileViewController.nibInstance(), tabTitle: "Health Profile", tabIcon: UIImage.tabIcon_healthProfile())
            coverage = navigationController(CoverageViewController.nibInstance(), tabTitle: "Coverage", tabIcon: UIImage.tabIcon_coverage())
            manageConnection = navigationController(ManageConnectionsViewController.nibInstance(), tabTitle: "Manage Connections", tabIcon: UIImage.tabIcon_manageConnections())
    //        let myProfile = navigationController(ProfileViewController.nibInstance(), tabTitle: "Profile", tabIcon: UIImage.tabIcon_coverage())

            viewConntrollers = [ coverage, manageConnection]
        }
    @IBAction func pressedButtonAction(_ sender : UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewConntrollers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        sender.isSelected = true
        let vc = viewConntrollers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        buttons[selectedIndex].isSelected = true
//        pressedButtonAction(buttons[selectedIndex])
    }

}
extension TabViewController {

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
