//
//  AppDelegate.swift
//  HealthProfiler
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //setup/customize app launch
        setupApplicationLaunch()

        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        OAuthSwift.handle(url: url)
        return true
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        guard let url = URLContexts.first?.url else {
            return
        }
        OAuthSwift.handle(url: url)
    }
}


extension AppDelegate {
    
    private func setupApplicationLaunch() {
        
        //init/setup window and navigationController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppCoordinator.shared.getRootContainer()
        
        //customize appearance
        AppTheme.applyAppearance()
        
        //load dummy data
        DummyData.shared.loadUserData_demo()
        
        window?.makeKeyAndVisible()
        
        //enable network logging
        //href: https://developer.apple.com/documentation/network/debugging_https_problems_with_cfnetwork_diagnostic_logging
        setenv("CFNETWORK_DIAGNOSTICS", "3", 1)
    }
}
