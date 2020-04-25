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
        let home = navigationController(HomeViewController.nibInstance(), tabTitle: "Home", tabIcon: nil)
        let healthProfiler = navigationController(HealthProfileViewController.nibInstance(), tabTitle: "Home", tabIcon: nil)
        let coverage = navigationController(CoverageViewController.nibInstance(), tabTitle: "Home", tabIcon: nil)
        let manageConnections = navigationController(ManageConnectionsViewController.nibInstance(), tabTitle: "Home", tabIcon: nil)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [home,healthProfiler, coverage, manageConnections]
        
        let menu = MenuViewController.nibInstance()
        push(controller: DrawerWrapper(tabBarController, leftVC: menu))
    }
    
    private func navigationController(_ rootController: UIViewController,
                                      tabTitle: String,
                                      tabIcon: String?) -> UINavigationController {
        
        rootController.tabBarItem = UITabBarItem.init(title: tabTitle,
                                                      image: nil,
                                                      selectedImage: nil)
        rootController.addDrawerButton()
        return UINavigationController(rootViewController: rootController)
    }
}


//MARK: Public methods
extension LoginViewController {
    
}
