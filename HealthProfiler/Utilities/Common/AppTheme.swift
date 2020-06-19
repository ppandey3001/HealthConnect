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
        UITabBar.appearance().barTintColor = .white //bar background color
        UITabBar.appearance().tintColor = UIColor.appHeaderColor() //selected itm color
        UITabBar.appearance().unselectedItemTintColor = .lightGray //unselected itm color
        UITabBar.appearance().isTranslucent = false
    }
}
