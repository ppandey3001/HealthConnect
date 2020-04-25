//
//  LoginViewController.swift
//  HealthProfiler
//

import UIKit

class LoginViewController: HPViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        navigateToDashboard()
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        
        container()?.showBrandingBar(true)
        push(controller: RegistrationViewController.nibInstance())
    }
}

//MARK: Private methods
private extension LoginViewController {
    
    private func setupController() {
        
        container()?.showBrandingBar(false)
    }
    
    private func navigateToDashboard() {
        
        //clear and reset input boxes and check boxes
        
        //show custom branding bar
        container()?.showBrandingBar(true)
        
        
        //Create new dashboard, and push
        
        /*
         TODO: need to move this code snippet to common place so it can be accessible from registration controller too
         */
        let home = navigationController(HomeViewController.nibInstance(), tabTitle: "Home", tabIcon: "Hamburger")
        let healthProfile = navigationController(HealthProfileViewController.nibInstance(), tabTitle: "Health Profile", tabIcon: "Hamburger")
        let coverage = navigationController(CoverageViewController.nibInstance(), tabTitle: "Coverage", tabIcon: "Hamburger")
        let manageConnections = navigationController(ManageConnectionsViewController.nibInstance(), tabTitle: "Manage Connections", tabIcon: "Hamburger")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [home,healthProfile, coverage, manageConnections]
        
        let menu = MenuViewController.nibInstance()
        push(controller: DrawerWrapper(tabBarController, leftVC: menu))
    }
    
    private func navigationController(_ rootController: UIViewController,
                                      tabTitle: String,
                                      tabIcon: String) -> UINavigationController {
        
        rootController.tabBarItem = UITabBarItem.init(title: tabTitle,
                                                      image: UIImage(named: tabIcon),
                                                      selectedImage: UIImage(named: tabIcon))
//        rootController.title = tabTitle
        rootController.addDrawerButton()
        return UINavigationController(rootViewController: rootController)
    }
}


//MARK: Public methods
extension LoginViewController {
    
}
