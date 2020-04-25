//
//  AppTheme.swift
//  HealthProfiler
//

import Foundation
import UIKit

class AppTheme {

    class func applyAppearance() {
        
        /// UINavigationBar
        UINavigationBar.appearance().barStyle = UIBarStyle.blackOpaque
        UINavigationBar.appearance().barTintColor = UIColor.appHeaderColor()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //removes 1px line shadow line underneath UINavigationBar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        /// UITabBar
        UITabBar.appearance().tintColor = UIColor.appHeaderColor()
        UITabBar.appearance().unselectedItemTintColor = UIColor.appHeaderColor()
//        UITabBar.appearance().selectionIndicatorImage = UIColor.themePrimaryColor().image().resizableImage(withCapInsets: UIEdgeInsets(top: 0.001, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
//        UITabBar.appearance().selectionIndicatorImage = UIColor.themePrimaryColor().image(w: 200.0, h:120.0).resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        UITabBar.appearance().selectionIndicatorImage = UIColor.themePrimaryColor().image(w: UIScreen.main.bounds.width / 4.0, h:120.0)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.colorFromRGB(224.0, 224.0, 224.0)
        
        //removes 1px line shadow line at the top of UITabBar
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().clipsToBounds = true

        /// UITabBarItem
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for:.selected)
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset.init(horizontal: 0.0, vertical: 2.0)
    }
}
