//
//  AppDelegate.swift
//  HealthProfiler
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //setup/customize app launch
        setupApplicationLaunch()
        
        return true
    }
}


extension AppDelegate {
    
    private func setupApplicationLaunch() {
        
        //init/setup window and navigationController
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController(rootViewController: LoginViewController.nibInstance())
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = AppContainer(navigationController!)
        
        window?.makeKeyAndVisible()
    }
}


