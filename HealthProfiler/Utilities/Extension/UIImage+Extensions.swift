//
//  UIImage+Extensions.swift
//  HealthProfiler
//

import Foundation
import UIKit

extension UIImage {
    
    class func originalImage(name: String) -> UIImage? {
        return (UIImage(named: name)?.withRenderingMode(.alwaysOriginal))
    }
    
    class func templateImage(name:String) -> UIImage? {
        return (UIImage(named: name)?.withRenderingMode(.alwaysTemplate))
    }
    
    //bottom tab bar icon
    class func tabIcon_home() -> UIImage? {
        return UIImage.templateImage(name: "HomeIcon")
    }
    
    class func tabIcon_healthProfile() -> UIImage? {
        return UIImage.templateImage(name: "HealthProfileIcon")
    }
    
    class func tabIcon_coverage() -> UIImage? {
        return UIImage.templateImage(name: "CoverageIcon")
    }
    
    class func tabIcon_manageConnections() -> UIImage? {
        return UIImage.templateImage(name: "ManageConnections")
    }
    
    class func tabIcon_myProfile() -> UIImage? {
        return UIImage.templateImage(name: "user-icon")
    }
    
}

extension UIImage {
    
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}
