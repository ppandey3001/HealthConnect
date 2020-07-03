//
//  AppDelegate.swift
//  HealthProfiler
//

import UIKit
import OAuthSwift
import ScrollableSegmentedControl

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //setup/customize app launch
        
        setUpSegementControl()
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
        
    }
    
    private func setUpSegementControl() {
        
        let segmentedControlAppearance = ScrollableSegmentedControl.appearance()
        segmentedControlAppearance.segmentContentColor = UIColor.white
        segmentedControlAppearance.selectedSegmentContentColor = UIColor.yellow
        segmentedControlAppearance.backgroundColor = UIColor.black
        
    }
}
