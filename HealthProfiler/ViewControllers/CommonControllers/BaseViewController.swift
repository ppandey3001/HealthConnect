//
//  BaseViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 21/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, NavBarDelegate {
    func signOutPressed() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//           }

        // Do any additional setup after loading the view.
    }
    
    func setUpTopBar () {
        let headerView = NavBar.instanceFromNib()
        if (UIScreen.main.bounds.width <= 375) {
             headerView.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 60)
        } else {
            headerView.frame = CGRect(x: 0, y: 80, width: self.view.bounds.width, height: 60)
        }
        if self.isKind(of: RegistrationViewController.self){
            headerView.signOutButton.isHidden = true
        }
        self.view.addSubview(headerView)
        headerView.delegate = self
    }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        if let tabBarVC = self.tabBarController as? TabBarViewController {
//            tabBarVC.bottomView.isHidden = false
//            tabBarVC.tabBar.isHidden = false
//        }
//    }
//
//    func hideBottomView() {
//        if let tabBarVC = self.tabBarController as? TabBarViewController {
//            tabBarVC.bottomView.isHidden = true
//            tabBarVC.tabBar.isHidden = true
//        }
//    }
    

}
